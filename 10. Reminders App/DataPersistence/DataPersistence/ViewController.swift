//
//  ViewController.swift
//  DataPersistence
//
//  Created by Lee Bennett on 12/31/19.
//  Copyright © 2019 MadeSimple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // URL for the location to save our data
      var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      print("path to doc directory is \(url)")
      url.appendPathComponent("myData.txt")
        
        // First check to see if file exists at given url
        if FileManager.default.fileExists(atPath: url.path){
            textTextField.text = try! String(contentsOf: url, encoding: .utf8)
        }
    }
    
    @IBAction func saveDidTapped(_ sender: UIButton) {
        // URL for the location to save our data
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("path to doc directory is \(url)")
        url.appendPathComponent("myData.txt")
        // /path/of/docment/directory/myData.txt
        // If the user has entered text in the text field, save data to our url
        if let data = textTextField.text?.data(using: .utf8){
            try! data.write(to: url)
        }
    }
    

}

