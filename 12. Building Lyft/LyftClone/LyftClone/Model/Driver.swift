//
//  Driver.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/7/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation
import CoreLocation

class Driver{
    let name: String
    let thumbnail: String
    let licenseNumber: String
    let rating: Float
    let car: String
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, thumbnail: String, licenseNumber: String, rating: Float, car: String, coordinate: CLLocationCoordinate2D){
        self.name = name
        self.thumbnail = thumbnail
        self.licenseNumber = licenseNumber
        self.rating = rating
        self.car = car
        self.coordinate = coordinate
    }
}
