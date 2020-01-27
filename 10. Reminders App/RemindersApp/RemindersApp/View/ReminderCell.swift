//
//  ReminderCell.swift
//  RemindersApp
//
//  Created by Lee Bennett on 12/31/19.
//  Copyright © 2019 MadeSimple. All rights reserved.
//

import UIKit

class ReminderCell: UITableViewCell{
    @IBOutlet weak var isCompletedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    func update(reminder: Reminder, index: Int){
        titleLabel.text = reminder.title
        
        infoButton.tag = index

        isCompletedView.layer.cornerRadius = isCompletedView.frame.size.width / 2.0
        isCompletedView.layer.borderColor = UIColor.lightGray.cgColor
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mma"
        dateLabel.text = dateFormatter.string(from: reminder.date)
        
        if reminder.isCompleted{
            isCompletedView.backgroundColor = UIColor.green
            isCompletedView.layer.borderWidth = 0.0
        } else{
            isCompletedView.backgroundColor = UIColor.white
            isCompletedView.layer.borderWidth = 2.0
        }
        
    }
    
}
