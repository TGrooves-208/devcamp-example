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

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
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
}



