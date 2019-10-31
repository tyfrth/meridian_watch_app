//
//  SessionHandler.swift
//  meridian_watch_app
//
//  Created by Tyler Frith on 10/31/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import Foundation
import WatchConnectivity

class SessionHandler: NSObject, WCSessionDelegate {
    
    static let shared = SessionHandler()
    
    private var session = WCSession.default
    
    override init() {
        super.init()
        
        if isSupported() {
            session.delegate = self
            session.activate()
        }
    
    print("isPaired?: \(session.isPaired), isWatchAppInstalled?: \(session.isWatchAppInstalled)")
        
    }
    
    func isSupported() -> Bool {
    return WCSession.isSupported()
    }
    
    //session delegates
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidCompleteWith activationState:\(activationState) error:\(String(describing: error))")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive: \(session)")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
          print("sessionDidDeactivate: \(session)")
        
        self.session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if message["request"] as? String == "version" {
            replyHandler(["version" : "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "No version")"])
        }
    }
    
}
