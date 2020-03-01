//
//  AlbumCell.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/9/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit

class AlbumCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    func update(album: Album){
        thumbnailImageView.image = UIImage(named: album.image)
        titleLabel.text = album.name
        artistLabel.text = album.artist
    }
}
