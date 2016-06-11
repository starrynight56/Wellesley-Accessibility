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

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate{
  
    let latCenter = 42.292576
    let lonCenter = -71.307917//center of map
    
    @IBOutlet weak var mapView: GMSMapView!//mapView
    
    let locationManager = CLLocationManager()//used for setting starting user location

    let wheelchairRamps: [ramp] = [ramp(latitude: 42.288388, longitude: -71.302619, bearing: 305),//meticulous hardcoded bs
                                   ramp(latitude: 42.289770, longitude: -71.301117, bearing: 258),
                                   ramp(latitude: 42.290682, longitude: -71.302286, bearing: 175),
                                   ramp(latitude: 42.291301, longitude: -71.303023, bearing: 184),
                                   ramp(latitude: 42.292063, longitude: -71.299888, bearing: 160),
                                   ramp(latitude: 42.292250, longitude: -71.300832, bearing: 145),
                                   ramp(latitude: 42.291392, longitude: -71.304294, bearing: 290),
                                   ramp(latitude: 42.291383, longitude: -71.304814, bearing: 80),
                                   ramp(latitude: 42.291323, longitude: -71.305165, bearing: 195)]
    
    var markerList: [GMSMarker] = [GMSMarker]()//list of acccessible entrance markers
    var overlayList: [GMSGroundOverlay] = [GMSGroundOverlay]()//list of triangle thingies to represent accessible entrances

    var zoom: Float = 15.3//initial zoom (zoomed out 100%)
    var bearing: Double = 270//orientation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraPosition = GMSCameraPosition.cameraWithLatitude(latCenter,
            longitude: lonCenter
            , zoom: zoom, bearing: bearing, viewingAngle: 0)//initial camera position
        
        mapView.myLocationEnabled=true//put locations of user on map

        mapView.camera = cameraPosition//set camera position
       
        mapView.delegate = self//used to add map methods
       
        mapView.setMinZoom(15.3, maxZoom: mapView.maxZoom)//constrain to restrict zoom
 
        locationManager.delegate = self//used to set initial user location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let icon = UIImage(named: "triangle")// icon for triangles
        
        for currentRamp in wheelchairRamps//look through all ramp structs
        {
            
            let southWest = CLLocationCoordinate2D(latitude: currentRamp.latitude-0.0001, longitude:currentRamp.longitude-0.0001)
            let northEast = CLLocationCoordinate2D(latitude: currentRamp.latitude+0.0001, longitude: currentRamp.longitude+0.0001)
            let overlayBounds = GMSCoordinateBounds(coordinate: southWest, coordinate: northEast)
            let overlay = GMSGroundOverlay(bounds: overlayBounds, icon: icon)
            overlay.bearing = currentRamp.bearing
            overlay.tappable=true//creates ground overlays for accessibile entrances

            
            
            let position = CLLocationCoordinate2DMake(currentRamp.latitude, currentRamp.longitude)
            let marker = GMSMarker(position: position)//creates accessible entrance markers
            //marker.title = "Wheelchair Accessible"
            //marker.icon = UIImage(named: "wheelchairMarker")
            //marker.map = mapView
            
            markerList.append(marker)
            overlayList.append(overlay)//add markers and overlays to respective arrays
            
        }
  
     
    }

    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {

        //print(position.target.latitude)
        //print(position.target.longitude)
      
        zoom = position.zoom//update zoom
        bearing = position.bearing//update bearing
        
        if zoom >= 16 && overlayList[0].map==nil // if we have zoomed in far enough to see buildings and the triangles are off,
        {
            for overlay in overlayList
            {
                overlay.map=mapView //turn all triangles on
            }
        }
        else
        if zoom<16 && overlayList[0].map != nil //if we have zoomed out and cant see buildings and triangles are on,
        {
            for overlay in overlayList
            {
                overlay.map=nil //turn all triangles off
            }
        }
        
        //set limits for map to constrain it
        let difference = 0.00000005*pow(2,Double(position.zoom))
        let upperLat = latCenter+difference
        let lowerLat = latCenter-difference
        let upperLon = lonCenter+4*difference
        let lowerLon = lonCenter-4*difference
        
        
        //whole bunch of shit to prevent leaving the campus
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
        //send self to information view controller
        let destination : InformationViewController = segue.destinationViewController as! InformationViewController
        destination.mapViewController = self
    }
 
    func mapView(mapView: GMSMapView!, didTapOverlay overlay: GMSOverlay!) {
        //code for taps of overlays if required
    }
    
    @IBAction func wheelchairShow(sender: UIButton)
    {
        //turn wheelchair markers on and off
        if(sender.backgroundColor == UIColor.greenColor())
        {
            sender.backgroundColor = UIColor.whiteColor()
            
            for marker in markerList
            {
                marker.map = nil
            }
           
        }
        else
        {
            sender.backgroundColor = UIColor.greenColor()
            for marker in markerList
            {
                marker.map = mapView
            }
        }

    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        zoom = 18//zoom into user
        
        let initialLoc = locations.last//last location of the user
        let latitude = initialLoc!.coordinate.latitude
        let longitude = initialLoc!.coordinate.longitude

        //check if initalLoc is in the campus
        if(latitude>42.287959 && latitude<42.296429 && longitude > -71.318803 && longitude < -71.295299)
        {
            
            let initialCamera = GMSCameraPosition.cameraWithLatitude(latitude,
                                                                    longitude: longitude
                , zoom: zoom, bearing: bearing, viewingAngle: 0)//set camera zoomed in on user
            
            mapView.animateToCameraPosition(initialCamera)//set map to camera
            locationManager.stopUpdatingLocation()//stop running enclosed method because user has been found within the campus

        }
        
    }
    



}
//ramp struct declaration
struct ramp {
    let latitude: Double
    let longitude: Double
    let bearing: Double
}