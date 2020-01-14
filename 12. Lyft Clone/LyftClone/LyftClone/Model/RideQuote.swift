//
//  RideQuote.swift
//  LyftClone
//
//  Created by Lee Bennett on 1/5/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation

class RideQuote{
    let thumbnail: String
    let name: String
    let capacity: String
    let price: Double
    let time: Date
    
    init(thumbnail: String, name: String, capacity: String, price: Double, time: Date){
        self.thumbnail = thumbnail
        self.name = name
        self.capacity = capacity
        self.price = price
        self.time = time
    }
}
