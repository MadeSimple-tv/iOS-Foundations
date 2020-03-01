//
//  RideQuoteService.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/5/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation
import CoreLocation

class RideQuoteService{
    static let shared = RideQuoteService()
    
    private init(){}
    
    func getQuotes(pickupLocation: Location, dropffLocation: Location) -> [RideQuote]{
        let location1 = CLLocation(latitude: pickupLocation.lat, longitude: pickupLocation.lng)
        let location2 = CLLocation(latitude: dropffLocation.lat, longitude: dropffLocation.lng)
        
        // Meters
        let distance = location1.distance(from: location2)
        let minimumAmount = 3.0
        
        return [
            RideQuote(thumbnail: "ride-shared", name: "Shared", capacity: "1-2", price: minimumAmount + (distance * 0.005), time: Date()),
            RideQuote(thumbnail: "ride-compact", name: "Compact", capacity: "4", price: minimumAmount + (distance * 0.009), time: Date()),
            RideQuote(thumbnail: "ride-large", name: "Large", capacity: "6", price: minimumAmount + (distance * 0.015), time: Date())
        ]
    }
}
