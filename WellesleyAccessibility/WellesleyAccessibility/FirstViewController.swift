//
//  FirstViewController.swift
//  WellesleyAccessibility
//
//  Created by Vikram Mullick on 6/6/16.
//  Copyright © 2016 Rosanne and Vikram. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation=true
       
        self.mapView.mapType = MKMapType.SatelliteFlyover
        let dropPin = MKPointAnnotation()
        let wellesleyLocation = CLLocationCoordinate2DMake(42.293068, -71.308583)
        dropPin.coordinate = wellesleyLocation
        dropPin.title = "Wellesley"
        let center = CLLocationCoordinate2DMake(wellesleyLocation.latitude, wellesleyLocation.longitude)
        let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.01,0.01))
        self.mapView.setRegion(region, animated:true)

        mapView.addAnnotation(dropPin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

