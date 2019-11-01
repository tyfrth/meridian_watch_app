//
//  MSDirectionsViewController.swift
//  MeridianSwiftSamples
//
//  Created by Stephen Kelly on 5/22/17.
//  Copyright © 2017 Aruba Networks. All rights reserved.
//

import UIKit

class MSDirectionsViewController: MRMapViewController {
    private var directions: MRDirections?
    private var directionsVisible = true
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        mapView.mapKey = MREditorKey(forMap: MSExampleHost.mapID(), app: MSExampleHost.appID())
        mapView.showsUserLocation = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let button0 = UIBarButtonItem(title: "Overview", style: .plain, target: self, action: #selector(overviewAction))
        let button1 = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(hideAction))
        let button2 = UIBarButtonItem(title: "Last", style: .plain, target: self, action: #selector(lastStepAction))
        let button3 = UIBarButtonItem(title: "DirTo:", style: .plain, target: self, action: #selector(directionsToAction))
        let button4 = UIBarButtonItem(title: "DirFrom", style: .plain, target: self, action: #selector(directionsFromAction))
        navigationItem.rightBarButtonItems = [button0, button1, button2, button3, button4]
    }

    // MARK: - MSExampleViewController

    static func exampleTitle() -> String {
        return "Directions"
    }

    static func exampleDetail() -> String {
        return """
        Example of various route API usage.
        
        • `DirTo.` button to start and stop directions to the selected placemark.
        • `DirFrom.` button to start and stop directions from the selected placemark.
        • `Last.` button to jump to the last step.
        • `Hide.` button to show/hide the directions control.
        • `Overview` button to scroll to the full route path.
        """
    }

    // MARK: - Action

    @objc private func overviewAction() {
        mapView.scrollToOverview()
    }

    @objc private func hideAction() {
        mapView.setDirectionsControlVisible(directionsVisible)
        directionsVisible = !directionsVisible
    }

    @objc private func lastStepAction() {
        if let stepCount = mapView.route?.steps?.count {
            mapView.setRouteStep(UInt(stepCount - 1), animated: true)
        }
    }

    @objc private func directionsToAction() {
        if mapView.route != nil {
            mapView.setRoute(nil, animated: true)
            return
        }

        guard let appKey = mapView.mapKey.parent else {
            return
        }
        guard let destinationAnnotation = mapView.selectedAnnotation as? MRPlacemark else {
            return
        }
        let request = MRDirectionsRequest()
        request.app = appKey
        request.destination = MRDirectionsDestination(placemarkKey: destinationAnnotation.key)
        request.source = MRDirectionsSource.withCurrentLocation()
        directions = MRDirections(request: request, presenting: self)
        directions?.calculate(completionHandler: {[weak self] (response, error) in
            self?.directionsResponseDidLoad(response: response, error: error)
        })
    }

    @objc private func directionsFromAction() {
        if mapView.route != nil {
            mapView.setRoute(nil, animated: true)
            return
        }

        guard let appKey = mapView.mapKey.parent else {
            return
        }
        guard let sourceAnnotation = mapView.selectedAnnotation as? MRPlacemark else {
            return
        }
        let request = MRDirectionsRequest()
        request.app = appKey
        request.destination = MRDirectionsDestination.withCurrentLocation()
        request.source = MRDirectionsSource(placemarkKey: sourceAnnotation.key)
        directions = MRDirections(request: request, presenting: self)
        directions?.calculate(completionHandler: {[weak self] (response, error) in
            self?.directionsResponseDidLoad(response: response, error: error)
        })
    }

    // MARK: - Internal

    private func directionsResponseDidLoad(response: MRDirectionsResponse?, error: Error?) {
        directions = nil
        if let routeResponse = response?.routes, error == nil, routeResponse.count > 0 {
            mapView.deselectAnnotation(animated: false)
            mapView.setRoute(routeResponse[0], animated: true)
            return
        }

        // Error or no routes:
        let alertController = UIAlertController(title: "Could not load directions", message: error?.localizedDescription, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
}
