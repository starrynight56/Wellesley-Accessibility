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

class ViewController: UIViewController, GMSMapViewDelegate{
  
    
    let latCenter = 42.292576
    let lonCenter = -71.307917
    @IBOutlet weak var mapView: GMSMapView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraPosition = GMSCameraPosition.cameraWithLatitude(latCenter,
            longitude: lonCenter
            , zoom: 15.3, bearing: 270, viewingAngle: 0)
        
        mapView.myLocationEnabled=true

        mapView.camera = cameraPosition
       
        mapView.delegate = self
       
        mapView.setMinZoom(15.3, maxZoom: mapView.maxZoom)
        
        mapView.mapType = GoogleMaps.kGMSTypeNormal

 
        //marker code
        /*
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latCenter, lonCenter)
        marker.title = "Wellesley"
        marker.snippet = "Wellesley"
        marker.map = mapView

        
        let position = CLLocationCoordinate2DMake(latCenter, lonCenter)
        let london = GMSMarker(position: position)
        london.title = "London"
        london.icon = UIImage(named: "blue2")
        london.map = mapView*/
        
        

    }

    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {

        //print(position.target.latitude)
        //print(position.target.longitude)
      
        let difference = 0.00000005*pow(2,Double(position.zoom))
        let upperLat = latCenter+difference
        let lowerLat = latCenter-difference
        let upperLon = lonCenter+4*difference
        let lowerLon = lonCenter-4*difference
        
        if (position.target.latitude > upperLat) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(upperLat-0.0001,
                longitude: position.target.longitude
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)
           
            mapView.animateToCameraPosition(goBackCamera)
            
        }
        if (position.target.longitude > upperLon) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(position.target.latitude,
                longitude: upperLon-0.0001
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)

            mapView.animateToCameraPosition(goBackCamera)
            
        }
        if (position.target.latitude < lowerLat) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(lowerLat+0.0001,
                longitude: position.target.longitude
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)
     
            mapView.animateToCameraPosition(goBackCamera)
            
        }
        if (position.target.longitude < lowerLon) {
            let goBackCamera = GMSCameraPosition.cameraWithLatitude(position.target.latitude,
                longitude: lowerLon+0.0001
                , zoom: position.zoom, bearing: position.bearing, viewingAngle: position.viewingAngle)
        
            mapView.animateToCameraPosition(goBackCamera)
            
        }
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destination : InformationViewController = segue.destinationViewController as! InformationViewController
        
        destination.mapViewController = self
    }
    

}