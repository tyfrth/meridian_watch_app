//
//  HACKHost.swift
//  meridian_watch_app
//
//  Created by Paige Mckinney on 10/31/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

// Below we are using a known App ID and Map ID from the Meridian Editor. You can find these IDs
// by navigating to the map you want in the Editor, for instance here's a sample URL for the
// Placemark editor for a Map:
//
//     https://edit.meridianapps.com/apps/5809862863224832/versions/1/maps/5668600916475904/placemarks
//                                            [APP ID]                          [MAP ID]

let APP_ID_US = "5809862863224832"
let MAP_ID_US = "5668600916475904"

// SHELL: APP_ID and MAP _ID
let APP_ID_SHELL = "4933439129649152"
let MAP_ID_SHELL = "5722646637445120"

// EU: APP_ID and MAP_ID
let APP_ID_EU = "4856321132199936"
let MAP_ID_EU = "5752754626625536"

class MSExampleHost: NSObject {
    @objc dynamic class func appID() -> String {
        if Meridian.sharedConfig()?.domainConfig.domainRegion == MRDomainRegion.EU {
            return APP_ID_US
        }
        return APP_ID_US
    }
    @objc dynamic class func mapID() -> String {
        if Meridian.sharedConfig()?.domainConfig.domainRegion == MRDomainRegion.EU {
            return MAP_ID_EU
        }
        return MAP_ID_US
    }
}
