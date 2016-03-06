//
//  SecondViewController.swift
//  DevBootcamps
//
//  Created by Gil Aguilar on 3/2/16.
//  Copyright © 2016 redeye-dev. All rights reserved.
//

import UIKit
import MapKit

class LocationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    //This is how you set the zoom level for an app in meters
    let regionRadius: CLLocationDistance = 1000
    
    //A users location needs a location manger and we instantiate it from the get go
    let locationManager = CLLocationManager()
    
    //Addresses of my favorite coffee shops just an array with the information as a String
    let addresses = [ "12473 W Chinden Blvd, Boise, ID 83713", "219 N 8th St, Boise, ID 83702","8205 W Rifleman St, Boise, ID 83704"]

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //this is an async type function
        for add in addresses {
            getPlacemarkFromAddress(add)
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthStatus()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //When the app gets the users location we will listen for it grab that users location and then
    //pass it to this centerMapOnLoaction and zoom in on that location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
        
    }
    
    //When the app gets the users location it will call back the delegate that the location was updated
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        if let loc = userLocation.location {
        centerMapOnLocation(loc)
            
        }
    }
    
    //This is called before the annotation pins drop allowing us to customize them as we feel fit
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(BootcampAnnotation) {
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.greenColor()
            annoView.animatesDrop = true
            return annoView
            
        } else if annotation.isKindOfClass(MKUserLocation) {
            return nil
        }
        
        return nil
    }
    
    func createAnnotationForLocation(location: CLLocation) {
        let bootcamp = BootcampAnnotation(coordinate: location.coordinate)
        map.addAnnotation(bootcamp)
    }
    
    //Most people use Google API's but we can tap into Apples's API through GeoCoding (taking string based addresses and making them into coordinates) as follows
    func getPlacemarkFromAddress(address: String) {
        CLGeocoder().geocodeAddressString(address) { (placemarks:[CLPlacemark]?, error:NSError?) -> Void in
            if let marks = placemarks where marks.count > 0 {
                if let loc = marks[0].location {
                    //We have a valid location with coordinates
                    self.createAnnotationForLocation(loc)
                }
            }
        }
    }
}



