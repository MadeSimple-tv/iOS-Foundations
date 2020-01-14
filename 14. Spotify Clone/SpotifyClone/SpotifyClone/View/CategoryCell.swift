//
//  CategoryCell.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/9/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func update(category: Category, index: Int){
        titleLabel.text = category.title
        subtitleLabel.text = category.subtitle
        collectionView.tag = index
        collectionView.reloadData()
        
    }
    
}
