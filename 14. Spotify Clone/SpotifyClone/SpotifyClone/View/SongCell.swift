//
//  SongCell.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/10/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    func update(song: Song){
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
}
