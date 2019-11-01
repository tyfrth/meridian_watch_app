//
//  InterfaceController.swift
//  meridian_watch_app WatchKit Extension
//
//  Created by Paige Mckinney on 11/1/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    //    // Create our session property
    private var session = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("awake() - HostingController")
        // Configure interface
    }

    override func willActivate() {
        // called when the view controller is about to be visible to the user
        super.willActivate()
        print("willActivate() - HostingController")
        
        // If the session is supported, let's activate it
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
            print("activated the session?")
            sendMessage()
        }
    }

    override func didDeactivate() {
        // called when the view controller is no longer visible
        super.didDeactivate()
        print("didDeactivate() - HostingController")

    }
    
    //func didTouchUp(sender: UIButton)
    
    // Let's try sending a message to the device!
    func sendMessage() {
        if session.isReachable {
            session.sendMessage(["request" : "version"], replyHandler: nil, errorHandler: {(error) in print("Error sending message: %@", error)})
        } else {
            print("IPHONE COULDN'T BE REACHED")
        }
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
    }
    
}
