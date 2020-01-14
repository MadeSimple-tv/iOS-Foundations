//
//  ViewController.swift
//  Debugging
//
//  Created by Lee Bennett on 1/2/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func nextButtonDidTapped(_ sender: UIButton){
        let randomName = NameService.shared.getRandomName()
        nameLabel.text = randomName
    }

}

