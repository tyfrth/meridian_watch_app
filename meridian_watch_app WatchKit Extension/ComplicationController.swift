//
//  ComplicationController.swift
//  test-watch-app WatchKit Extension
//
//  Created by Daniel Sabo on 10/30/19.
//  Copyright © 2019 Daniel Sabo. All rights reserved.
//

import ClockKit

//---multipliers to convert to seconds---
let HOUR: TimeInterval = 60 * 60
let MINUTE: TimeInterval = 60

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration

    func getPlaceholderTemplateForComplication(
        complication: CLKComplication,
        withHandler handler: (CLKComplicationTemplate?) -> Void) {

        var template: CLKComplicationTemplate?
        switch complication.family {
            case .modularSmall:
                let modularSmallTemplate =
                    CLKComplicationTemplateModularSmallRingText()
                modularSmallTemplate.textProvider =
                    CLKSimpleTextProvider(text: "R")
                modularSmallTemplate.fillFraction = 0.75
                modularSmallTemplate.ringStyle = CLKComplicationRingStyle.closed
                template = modularSmallTemplate
            case .modularLarge:
                let meridianImage = UIImage(named: "meridian_image")
                
                let modularLargeTemplate =
                    CLKComplicationTemplateModularLargeStandardBody()
                modularLargeTemplate.headerImageProvider = CLKImageProvider(onePieceImage: meridianImage!)
                modularLargeTemplate.headerTextProvider = CLKSimpleTextProvider(text: "Sabotooth Tigers")
                template = modularLargeTemplate
            case .utilitarianSmall:
                template = nil
            case .utilitarianLarge:
                template = nil
            case .circularSmall:
                template = nil
            case .extraLarge:
                template = nil
            case .graphicCorner:
                template = nil
            case .graphicBezel:
                template = nil
            case .graphicCircular:
                template = nil
            case .graphicRectangular:
                template = nil
            case .utilitarianSmallFlat:
                template = nil
            @unknown default:
                template = nil
            }
            handler(template)
    }
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func createTimeLineEntry(headerText: String, bodyText: String, date: NSDate) -> CLKComplicationTimelineEntry {

        let template = CLKComplicationTemplateModularLargeStandardBody()
        let meridianImage = UIImage(named: "meridian_image")

        template.headerImageProvider =
        CLKImageProvider(onePieceImage: meridianImage!)
        template.headerTextProvider = CLKSimpleTextProvider(text: headerText)
        template.body1TextProvider = CLKSimpleTextProvider(text: bodyText)

        let entry = CLKComplicationTimelineEntry(date: date as Date,
            complicationTemplate: template)

        return(entry)
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
    
}
