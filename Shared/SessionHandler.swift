//
//  SessionHandler.swift
//  meridian_watch_app
//
//  Created by Tyler Frith on 10/31/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import Foundation
import WatchConnectivity

#if os(watchOS)
import ClockKit
#endif

extension Notification.Name {
    static let dataDidFlow = Notification.Name("DataDidFlow")
    static let activationDidComplete = Notification.Name("ActivationDidComplete")
    static let reachabilityDidChange = Notification.Name("ReachabilityDidChange")
}

class SessionHandler: NSObject, WCSessionDelegate {
    
    // Called when WCSession activation state is changed.
    //
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        postNotificationOnMainQueueAsync(name: .activationDidComplete)
    }
    
    // Called when WCSession reachability is changed.
    //
    func sessionReachabilityDidChange(_ session: WCSession) {
        postNotificationOnMainQueueAsync(name: .reachabilityDidChange)
    }
    
    // Called when an app context is received.
    //
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: "Received")
    }
    
    // Called when a message is received and the peer doesn't need a response.
    //
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: "Received")
    }
    
    // Called when a message is received and the peer needs a response.
    //
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        self.session(session, didReceiveMessage: message)
        replyHandler(message) // Echo back the time stamp.
    }
    
    // Called when a piece of message data is received and the peer doesn't need a response.
    //
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: "Received")
    }
    
    // Called when a piece of message data is received and the peer needs a response.
    //
    func session(_ session: WCSession, didReceiveMessageData messageData: Data, replyHandler: @escaping (Data) -> Void) {
        self.session(session, didReceiveMessageData: messageData)
        replyHandler(messageData) // Echo back the time stamp.
    }
    
    // Called when a directions is received.
    //
    func session(_ session: WCSession, didReceiveDirections directions: [String: Any] = [:]) {
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: "Received")
    }
    
    // Called when sending drections is done.
    //
    func session(_ session: WCSession, didFinish userInfoTransfer: WCSessionUserInfoTransfer, error: Error?) {
        postNotificationOnMainQueueAsync(name: .dataDidFlow, object: "Finished")
    }
    
    // WCSessionDelegate methods for iOS only.
    //
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        // Activate the new session after having switched to a new watch.
        session.activate()
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    #endif
    
    // Post a notification on the main thread asynchronously.
    //
    private func postNotificationOnMainQueueAsync(name: NSNotification.Name, object: String? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: name, object: object)
        }
    }
    
}
