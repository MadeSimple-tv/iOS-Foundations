//
//  ViewController.swift
//  TableViewExample
//
//  Created by Lee Bennett on 12/30/19.
//  Copyright © 2019 MadeSimple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{
    
    let people = ["Amy Adams", "Sam Smith", "Will Smith", "Jerry Brown", "James Lee"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvatarCell")! as! AvatarCell
        
        cell.nameLabel.text = people[indexPath.row]
        
        return cell
    }

}

