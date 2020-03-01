//
//  Album.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/9/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation

class Album: Codable{
    let name: String
    var followers: Int
    let artist: String
    let image: String
    let songs: [Song]
    
    init(name: String, followers: Int, artist: String, image: String, songs: [Song]){
        self.name = name
        self.followers = followers
        self.artist = artist
        self.image = image
        self.songs = songs
    }
}
