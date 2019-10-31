//
//  AppDelegate.swift
//  meridian_watch_app
//
//  Created by Tyler Frith on 10/30/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let config = MRConfig()
        
        // If samples are to be run via US servers, use these values
       config.applicationToken = "090c29d8b4cc628e4bd327abf37f62e4e3477bae"
       config.domainConfig.domainRegion = MRDomainRegion.default

       // If samples are to be run via EU servers, use these values
       // config.applicationToken = "50b4558f8fbfd96e26e122785e61b1589e1a13a5"
       // config.domainConfig.domainRegion = MRDomainRegion.EU;

       // must be called once, in application:didFinishLaunching
       Meridian.configure(config)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

