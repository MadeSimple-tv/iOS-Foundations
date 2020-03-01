//
//  LocationAnnotation.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/6/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    let locationType: String
    
    init(coordinate: CLLocationCoordinate2D, locationType: String){
        self.coordinate = coordinate
        self.locationType = locationType
    }
}
