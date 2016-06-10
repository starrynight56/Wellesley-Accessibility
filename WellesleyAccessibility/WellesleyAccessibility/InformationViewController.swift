//
//  InformationViewController.swift
//  WellesleyAccessibility
//
//  Created by Vikram Mullick on 6/9/16.
//  Copyright © 2016 Rosanne and Vikram. All rights reserved.
//

import UIKit
import GoogleMaps

class InformationViewController: UIViewController
{

    @IBOutlet weak var maptypeSegmentedControl: UISegmentedControl!
    
    var mapViewController : ViewController  = ViewController()
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
    
        switch mapViewController.mapView.mapType
        {
            case GoogleMaps.kGMSTypeNormal:
                maptypeSegmentedControl.selectedSegmentIndex=0
            case GoogleMaps.kGMSTypeTerrain:
                maptypeSegmentedControl.selectedSegmentIndex=1
            case GoogleMaps.kGMSTypeSatellite:
                maptypeSegmentedControl.selectedSegmentIndex=2
            default:
                print("default text")
        }
        
    }

    @IBAction func tapToResign(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    @IBAction func maptypePicked(sender: UISegmentedControl)
    {
        self.dismissViewControllerAnimated(true, completion: {})
        switch sender.selectedSegmentIndex
        {
            case 0:
                mapViewController.mapView.mapType = GoogleMaps.kGMSTypeNormal
            case 1:
                mapViewController.mapView.mapType = GoogleMaps.kGMSTypeTerrain
            case 2:
                mapViewController.mapView.mapType = GoogleMaps.kGMSTypeSatellite
            default:
                print("default text")

        }
        
      
        

    }
}