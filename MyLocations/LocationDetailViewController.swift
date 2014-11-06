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
import CoreData

class LocationDetailViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var locationNameTextField: UITextField!
    @IBOutlet weak var radiusTestField: UITextField!
    var selectedAnnotation: MKAnnotation!
    var locationManager: CLLocationManager!
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext

        self.locationLabel.text = "Latitude: \(self.selectedAnnotation.coordinate.latitude)"
        self.longitudeLabel.text = "Longitude: \(self.selectedAnnotation.coordinate.longitude)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addLocationButtonPressed(sender: AnyObject) {
        // Enter UI Element for user to enter name for identifier
        var newRadius: Double!
        if self.radiusTestField.text.validate() {
            println("text validated")
            newRadius = NSString(string: self.radiusTestField!.text).doubleValue
        } else {
            println("defaul to 100m radius")
            newRadius = 100
        }
        var geoFence = CLCircularRegion(center: self.selectedAnnotation.coordinate, radius: newRadius, identifier: self.locationNameTextField.text)
        self.locationManager.startMonitoringForRegion(geoFence)
        
        var newReminder = NSEntityDescription.insertNewObjectForEntityForName("Reminder", inManagedObjectContext: self.managedObjectContext) as Reminder
        newReminder.name = self.locationNameTextField!.text
        newReminder.latitude = self.selectedAnnotation.coordinate.latitude
        newReminder.longitude = self.selectedAnnotation.coordinate.longitude
        newReminder.date = NSDate()
        newReminder.radius = newRadius
        var error: NSError?
        self.managedObjectContext.save(&error)
        
        if error != nil {
            println(error?.localizedDescription)
        } else {
            println(newReminder.name + " saved")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        var locationInfo = [String : AnyObject]()
        locationInfo["name"] = self.locationNameTextField!.text
        locationInfo["latitude"] = self.selectedAnnotation.coordinate.latitude
        locationInfo["longitude"] = self.selectedAnnotation.coordinate.longitude
        locationInfo["radius"] = self.radiusTestField!.text
        locationInfo["region"] = geoFence
        
        NSNotificationCenter.defaultCenter().postNotificationName("REMINDER_ADDED", object: self, userInfo: locationInfo)
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
