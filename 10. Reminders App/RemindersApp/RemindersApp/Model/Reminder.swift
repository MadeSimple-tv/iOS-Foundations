//
//  Reminder.swift
//  RemindersApp
//
//  Created by Lee Bennett on 12/31/19.
//  Copyright © 2019 MadeSimple. All rights reserved.
//

import Foundation

class Reminder: Codable{
    var title: String
    var date: Date
    var isCompleted: Bool
    
    init(title: String, date: Date, isCompleted: Bool){
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}
