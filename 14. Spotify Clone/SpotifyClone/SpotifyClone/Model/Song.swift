//
//  Song.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/9/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation

class Song: Codable{
    let title: String
    let artist: String
    
    init(title: String, artist: String){
        self.title = title
        self.artist = artist
    }
}
