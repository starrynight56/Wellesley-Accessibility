//
//  ViewController.swift
//  WellesleyAccessibility
//
//  Created by Vikram Mullick on 6/8/16.
//  Copyright © 2016 Rosanne and Vikram. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.cameraWithLatitude(42.293,
            longitude: -71.306, zoom: 6)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(42.293, -71.306)
        marker.title = "Wellesley"
        marker.snippet = "Wellesley"
        marker.map = mapView
    }
}