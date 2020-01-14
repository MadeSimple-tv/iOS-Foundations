//
//  Category.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/9/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation

class Category: Codable{
    let title: String
    let subtitle: String
    let albums: [Album]
    
    init(title: String, subtitle: String, albums: [Album]){
        self.title = title
        self.subtitle = subtitle
        self.albums = albums
    }
}
