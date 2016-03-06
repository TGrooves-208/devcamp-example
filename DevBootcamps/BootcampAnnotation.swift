//
//  BootcampAnnotation.swift
//  DevBootcamps
//
//  Created by Gil Aguilar on 3/6/16.
//  Copyright © 2016 redeye-dev. All rights reserved.
//

import Foundation
import MapKit

class BootcampAnnotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
}


