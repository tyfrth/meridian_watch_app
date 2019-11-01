//
//  HACKMapViewController.swift
//  meridian_watch_app
//
//  Created by Paige Mckinney on 10/31/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import UIKit
import SwiftUI

class HACKMapViewController: MRMapViewController, SessionCommands {
    convenience init () {
        self.init(nibName:nil, bundle:nil)
        
        // Initialize our map view with our corresponding app and map keys
        mapView.mapKey = MREditorKey(forMap: HACKHost.mapID(), app: HACKHost.appID())
    }
    
    func sendDirections (currentStepIndex: Int) {
        if (mapView.route != nil) {
            // Do something here with sending data regarding the route to the phone
            print("ROUTE ISN'T NULL")
            // We can loop through the route steps here
            
            let currentRoute = mapView.route

            if let steps = currentRoute?.steps {
                let currentStep = steps[currentStepIndex]
                print("In if \(currentStep.instructions)")
                
                // Let's send some data, or at least create a dictionary to send here
                var dataToSend : [String:Any] = ["instructions":currentStep.instructions,
                                  "direction":currentStep.icon,
                                  "distanceForStep":currentStep.distance,
                                  "totalDistance":currentRoute?.distance
                    ]
                
                print("DIRECTIONS DICTIONARY")
                for element in dataToSend {
                    print(element.key)
                    print(element.value)
                }
                
                transferUserInfo(dataToSend)
            }
            //print("Out of if \(currentStep.instructions)")
            
            //We should use the routeStepIndex
        }
    }
    
    override func mapView(_ mapView: MRMapView, willScrollToStepAt index: UInt) {
        super.mapView(mapView, willScrollToStepAt: index)
        print(#function + " - index: \(index)")
        sendDirections(currentStepIndex: Int(index))
        
        
    }
    
}
