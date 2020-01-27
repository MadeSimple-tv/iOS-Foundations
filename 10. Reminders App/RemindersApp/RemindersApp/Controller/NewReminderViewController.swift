//
//  NewReminderViewController.swift
//  RemindersApp
//
//  Created by Lee Bennett on 12/31/19.
//  Copyright © 2019 MadeSimple. All rights reserved.
//

import UIKit

class NewReminderViewController: UIViewController{
    var reminderIndex: Int?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var completedSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let reminderIndex = reminderIndex{
            let reminder = ReminderService.shared.getReminder(index: reminderIndex)
            titleTextField.text = reminder.title
            datePicker.date = reminder.date
            completedSwitch.isOn = reminder.isCompleted
        }
    }
    
    @IBAction func saveButtonDidTapped(_ sender: UIButton) {
        let reminder = Reminder(title: titleTextField.text!,
                                date: datePicker.date,
                                isCompleted: completedSwitch.isOn)
        
        // Update a reminder
        if let reminderIndex = reminderIndex{
            ReminderService.shared.update(reminder: reminder, index: reminderIndex)
        // Else, create a new reminder object
        } else{
            ReminderService.shared.create(reminder: reminder)
        }
        
        navigationController!.popViewController(animated: true)
    }
}
