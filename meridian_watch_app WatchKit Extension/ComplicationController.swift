//
//  ComplicationController.swift
//  meridian_watch_app WatchKit Extension
//
//  Created by Tyler Frith on 10/30/19.
//  Copyright © 2019 sabotoothtigers. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    let timeLineText = ["➡ 300 ft", "⬅ 50 ft", "➡ 100 ft", "🔚 120 ft"]
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        
        let currentDate = Date()
        handler(currentDate)
        
//        switch userStatus.status {
//        case .idle:
//            handler(nil)
//        case .countingDown:
//            handler(userStatus.end.addingTimeInterval(-limit))
//        }
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        
        let currentDate = Date()
        handler(currentDate.addingTimeInterval(60*60))
//        switch userStatus.status {
//        case .idle:
//            handler(nil)
//        case .countingDown:
//            handler(userStatus.end)
//        }
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry

        if false,
            let template = self.currentTemplate(family: complication.family) {
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        } else if let template = self.placeholderTemplate(family: complication.family) {
            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(entry)
        } else {
            handler(nil)
        }
    }

    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        var entries: [CLKComplicationTimelineEntry] = []

        if true {
            if let template = self.placeholderTemplate(family: complication.family) {
                let endEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
                entries.append(endEntry)
            }

            if true,
                let template = self.placeholderTemplate(family: complication.family) {
                let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
                entries.append(entry)
            } else if let template = self.currentTemplate(family: complication.family) {
                let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
                entries.append(entry)
            }

            handler(entries)
        } else if let template = self.placeholderTemplate(family: complication.family) {
            let endEntry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
            entries.append(endEntry)

            handler(entries)
        } else {
            handler(entries)
        }
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached

        let template = self.placeholderTemplate(family: complication.family)
        handler(template)
    }

    func placeholderTemplate(family: CLKComplicationFamily) -> CLKComplicationTemplate? {
        let meridianImage = UIImage(named: "meridian_image")
        let rightArrow = UIImage(named: "tiny_right_arrow")
        let leftArrow = UIImage(named: "LeftArrow")
        
        let appNameTextProvider = CLKSimpleTextProvider(text: NSLocalizedString(" Meridian", comment: "Meridian"))
        let rightArrowProvier = CLKFullColorImageProvider(fullColorImage: rightArrow!)
        let simpleTextProvider = CLKSimpleTextProvider(text: "Meridian")
        let imageProvider = CLKImageProvider(onePieceImage: meridianImage!)
        let fullColor = CLKFullColorImageProvider(fullColorImage: meridianImage!)
        let gaugeProvider = CLKSimpleGaugeProvider(style: .fill, gaugeColor: .blue, fillFraction: 0)
        let tintColor = UIColor.blue

        switch family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallSimpleImage()
            template.imageProvider = imageProvider
            template.tintColor = tintColor
            return template

        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeSimpleText()
            template.textProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallSimpleText()
            template.textProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = appNameTextProvider
            template.bodyTextProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = appNameTextProvider
            template.tintColor = tintColor
            return template

        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerGaugeText()
            template.outerTextProvider = simpleTextProvider
            template.leadingTextProvider = CLKSimpleTextProvider(text: "here")
            template.trailingTextProvider = CLKSimpleTextProvider(text: "there")
            template.gaugeProvider = gaugeProvider
            return template

        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeImage()
            template.imageProvider = fullColor
            template.gaugeProvider = gaugeProvider
            return template

        case .graphicBezel:
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            let circularTemplate = self.placeholderTemplate(family: .graphicCircular)
            template.circularTemplate = circularTemplate as! CLKComplicationTemplateGraphicCircular
            template.textProvider = simpleTextProvider
            return template

        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
//            template.headerImageProvider = rightArrowProvier
            template.headerTextProvider = appNameTextProvider
            template.body1TextProvider = CLKSimpleTextProvider(text: "➡ 113ft")
                //CLKRelativeDateTextProvider(date: userStatus.end, style: .naturalFull, units: [.minute, .second])
            template.gaugeProvider = gaugeProvider
            template.tintColor = UIColor.blue
            return template

        @unknown default:
            return nil
        }
    }

    func currentTemplate(family: CLKComplicationFamily) -> CLKComplicationTemplate? {
        let meridianImage = UIImage(named: "meridian_image")
        
        let appNameTextProvider = CLKSimpleTextProvider(text: NSLocalizedString("Meridian", comment: "Meridian"))
        let simpleTextProvider = CLKSimpleTextProvider(text: "Meridian")
        let gaugeProvider = CLKTimeIntervalGaugeProvider(style: .fill, gaugeColors: [.green, .yellow, .orange], gaugeColorLocations: [0, 0.2, 0.8], start: Date(), end: Date())
        let imageProvider = CLKImageProvider(onePieceImage: meridianImage!)
        let fullColor = CLKFullColorImageProvider(fullColorImage: meridianImage!)
        let tintColor = UIColor.blue

        switch family {
        case .circularSmall:
            let template = CLKComplicationTemplateCircularSmallSimpleImage()
            template.imageProvider = imageProvider
            template.tintColor = tintColor
            return template

        case .extraLarge:
            let template = CLKComplicationTemplateExtraLargeStackText()
            template.line1TextProvider = simpleTextProvider
            template.line2TextProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .modularSmall:
            let template = CLKComplicationTemplateModularSmallStackText()
            template.line1TextProvider = simpleTextProvider
            template.line2TextProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .modularLarge:
            let template = CLKComplicationTemplateModularLargeTallBody()
            template.headerTextProvider = appNameTextProvider
            template.bodyTextProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .utilitarianSmall:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .utilitarianSmallFlat:
            let template = CLKComplicationTemplateUtilitarianSmallFlat()
            template.textProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .utilitarianLarge:
            let template = CLKComplicationTemplateUtilitarianLargeFlat()
            template.textProvider = simpleTextProvider
            template.tintColor = tintColor
            return template

        case .graphicCorner:
            let template = CLKComplicationTemplateGraphicCornerGaugeText()
            template.outerTextProvider = simpleTextProvider
            template.leadingTextProvider = CLKSimpleTextProvider(text: "here")
            template.trailingTextProvider = CLKSimpleTextProvider(text: "there")
            template.gaugeProvider = gaugeProvider
            return template

        case .graphicCircular:
            let template = CLKComplicationTemplateGraphicCircularClosedGaugeImage()
            template.imageProvider = fullColor
            template.gaugeProvider = gaugeProvider
            return template

        case .graphicBezel:
            let template = CLKComplicationTemplateGraphicBezelCircularText()
            let circularTemplate = self.currentTemplate(family: .graphicCircular)
            template.circularTemplate = circularTemplate as! CLKComplicationTemplateGraphicCircular
            template.textProvider = simpleTextProvider
            return template

        case .graphicRectangular:
            let template = CLKComplicationTemplateGraphicRectangularTextGauge()
            template.headerTextProvider = appNameTextProvider
            template.body1TextProvider = CLKSimpleTextProvider(text: "300ft")
                //CLKRelativeDateTextProvider(date: userStatus.end, style: .naturalFull, units: [.minute, .second])
            template.gaugeProvider = gaugeProvider
            template.tintColor = UIColor.blue
            return template

        @unknown default:
            return nil
        }
    }
}
