//
//  MapViewController.swift
//  MyLocations
//
//  Created by Reid Weber on 11/3/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.mapView.delegate = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "didLongPressMap:")
        self.mapView.addGestureRecognizer(longPress)
        
        switch CLLocationManager.authorizationStatus() as CLAuthorizationStatus {
        case .Authorized:
            println("Authorized")
            //self.locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        case .NotDetermined:
            println("Not Determined")
            // Need to request Auth and add keys to info.plist
            self.locationManager.requestAlwaysAuthorization()
        case .Denied:
            println("Denied")
        case .Restricted:
            println("Restricted")
        default:
            println("Default")
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reminderAdded:", name: "REMINDER_ADDED", object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didLongPressMap(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began {
            let touchPoint = sender.locationInView(self.mapView)
            let touchCoordinate = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinate
            annotation.title = "Add Reminder"
            
            self.mapView.addAnnotation(annotation)
        }
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "ANNOTATION")
        annotationView.animatesDrop = true
        annotationView.canShowCallout = true
        let addButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        annotationView.rightCalloutAccessoryView = addButton
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let destinationVC = self.storyboard?.instantiateViewControllerWithIdentifier("ADD_LOCATION_VC") as LocationDetailViewController
        destinationVC.selectedAnnotation = view.annotation
        destinationVC.locationManager = self.locationManager
        self.presentViewController(destinationVC, animated: true) { () -> Void in
            
        }
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.blueColor().colorWithAlphaComponent(0.20)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 1.0
        return renderer
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        println("Entered Region!")
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        println("Exited Region!")
    }
    
    func reminderAdded(notification: NSNotification) {
        println("Recieved Notification")
        var userInfo = notification.userInfo
        let newRegion = userInfo!["region"] as CLCircularRegion
        
        let overlay = MKCircle(centerCoordinate: newRegion.center, radius: newRegion.radius)
        self.mapView.addOverlay(overlay)
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
