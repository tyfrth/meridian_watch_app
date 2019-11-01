//
//  HACKMapViewController.swift
//  meridian_watch_app
//
//  Created by Paige Mckinney on 10/31/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import UIKit
import SwiftUI

class HACKMapViewController: MRMapViewController {
    convenience init () {
        self.init(nibName:nil, bundle:nil)
        
        // Initialize our map view with our corresponding app and map keys
        mapView.mapKey = MREditorKey(forMap: HACKHost.mapID(), app: HACKHost.appID())
    }
    
    func sendDirections () {
        if (mapView.route != nil) {
            // Do something here with sending data regarding the route to the phone
            
            // We can loop through the route steps here
            
            
            //We should use the routeStepIndex
        }
    }
}
