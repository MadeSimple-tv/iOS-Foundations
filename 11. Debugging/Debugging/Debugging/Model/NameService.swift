//
//  NameService.swift
//  Debugging
//
//  Created by Lee Bennett on 1/2/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation

class NameService{
    static let shared = NameService()
    
    let names = ["Alice", "Bob", "Jacob", "Kyle", "Sammy", "Alicia", "Mandy", "Anna"]
    
    private init(){}

    func getRandomName() -> String{
        let randomIndex = Int(arc4random_uniform(UInt32(names.count)))
        return names[randomIndex]
    }
}
