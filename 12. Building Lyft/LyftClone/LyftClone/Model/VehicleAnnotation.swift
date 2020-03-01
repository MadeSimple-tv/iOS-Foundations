//
//  VehicleAnnotation.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/5/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import MapKit

class VehicleAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
}
