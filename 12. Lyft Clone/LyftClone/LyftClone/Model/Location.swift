//
//  Location.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/5/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation
import MapKit

class Location: Codable{
    var title: String
    var subtitle: String
    let lat: Double
    let lng: Double
    
    init(title: String, subtitle: String, lat: Double, lng: Double){
        self.title = title
        self.subtitle = subtitle
        self.lat = lat
        self.lng = lng
    }
    
    init(placemark: MKPlacemark){
        self.title = placemark.name ?? ""
        self.subtitle = placemark.title ?? ""
        self.lat = placemark.coordinate.latitude
        self.lng = placemark.coordinate.longitude
    }
}
