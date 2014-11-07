//
//  LocationPresentationViewController.swift
//  MyLocations
//
//  Created by Reid Weber on 11/7/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import UIKit
import MapKit

class LocationPresentationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locationDateMadeLabel: UILabel!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var selectedResult: Reminder?
    var dateCreated: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        self.locationNameLabel.text = "Location: \(self.selectedResult!.name)"
        self.locationDateMadeLabel.text = "Date Created: \(self.dateCreated!)"
        self.mapView.showsUserLocation = true
        var annotation = MKPointAnnotation()
        annotation.coordinate = self.selectedResult!.getCoordinate()
        self.mapView.addAnnotation(annotation)
        self.mapView.setCenterCoordinate(annotation.coordinate, animated: false)
        self.mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(5.0), longitudeDelta: CLLocationDegrees(5.0))), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
