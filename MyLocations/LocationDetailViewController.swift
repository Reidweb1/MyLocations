//
//  LocationDetailViewController.swift
//  MyLocations
//
//  Created by Reid Weber on 11/3/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationDetailViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    var selectedAnnotation: MKAnnotation!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationLabel.text = "Latitude: \(self.selectedAnnotation.coordinate.latitude)"
        self.longitudeLabel.text = "Longitude: \(self.selectedAnnotation.coordinate.longitude)"
        
        println(self.selectedAnnotation.coordinate.latitude)
        println(self.selectedAnnotation.coordinate.longitude)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addLocationButtonPressed(sender: AnyObject) {
        // Enter UI Element for user to enter name for identifier
        var geoFence = CLCircularRegion(center: self.selectedAnnotation.coordinate, radius: 100.0, identifier: "New Location")
        self.locationManager.startMonitoringForRegion(geoFence)
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            // Save Location to Core Data
        })
        NSNotificationCenter.defaultCenter().postNotificationName("REMINDER_ADDED", object: self, userInfo: ["region" : geoFence])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
