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

    //segmented control for map type
    @IBOutlet weak var maptypeSegmentedControl: UISegmentedControl!
    // main view controller
    var mapViewController : ViewController  = ViewController()
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
    
        //set selected value on segmented control to appropriate selection
        switch mapViewController.mapView.mapType
        {
            case GoogleMaps.kGMSTypeNormal:
                maptypeSegmentedControl.selectedSegmentIndex=0
            case GoogleMaps.kGMSTypeSatellite:
                maptypeSegmentedControl.selectedSegmentIndex=1
            default:
                print("default text")//piece of code that will never run
        }
        
    }

    // resign view controller on tap away
    @IBAction func tapToResign(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    @IBAction func maptypePicked(sender: UISegmentedControl)
    {
        //change mapType of map view
        self.dismissViewControllerAnimated(true, completion: {})
        switch sender.selectedSegmentIndex
        {
            case 0:
                mapViewController.mapView.mapType = GoogleMaps.kGMSTypeNormal
            case 1:
                mapViewController.mapView.mapType = GoogleMaps.kGMSTypeSatellite
            default:
                print("default text")//piece of code that will never run

        }
        
      
        

    }
}