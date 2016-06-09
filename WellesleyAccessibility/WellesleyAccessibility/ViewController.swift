//
//  ViewController.swift
//  WellesleyAccessibility
//
//  Created by Vikram Mullick on 6/8/16.
//  Copyright © 2016 Rosanne and Vikram. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate{
  
    let latCenter = 42.293084
    let lonCenter = -71.307968
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraPosition = GMSCameraPosition.cameraWithLatitude(latCenter,
            longitude: lonCenter
            , zoom: 15.3, bearing: 270, viewingAngle: 0)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        mapView.myLocationEnabled=true

        mapView.camera = cameraPosition
       
        mapView.delegate = self
       
        mapView.setMinZoom(15.3, maxZoom: mapView.maxZoom)
        
        //marker code
        /*
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latCenter, lonCenter)
        marker.title = "Wellesley"
        marker.snippet = "Wellesley"
        marker.map = mapView*/


    }

    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {

        print(position.target.latitude)
        print(position.target.longitude)

        let difference = 0.000000017*pow(2,Double(position.zoom))
        let upperLat = latCenter+difference
        let lowerLat = latCenter-difference
        let upperLon = lonCenter+4.6*difference
        let lowerLon = lonCenter-4.6*difference
        
        if (position.target.latitude > upperLat) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(upperLat-0.0001,
                longitude: position.target.longitude
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)
           
            mapView.camera = goBackCamera;
            
        }
        if (position.target.longitude > upperLon) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(position.target.latitude,
                longitude: upperLon-0.0001
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)

            mapView.camera = goBackCamera;
            
        }
        if (position.target.latitude < lowerLat) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(lowerLat+0.0001,
                longitude: position.target.longitude
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)
     
            mapView.camera = goBackCamera;
            
        }
        if (position.target.longitude < lowerLon) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(position.target.latitude,
                longitude: lowerLon+0.0001
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)
        
            mapView.camera = goBackCamera;
            
        }
        
    }

}