//
//  LocationAnnotation.swift
//  Maps
//
//  Created by Lee Bennett on 1/4/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.coordinate = coordinate
    }
    
}
