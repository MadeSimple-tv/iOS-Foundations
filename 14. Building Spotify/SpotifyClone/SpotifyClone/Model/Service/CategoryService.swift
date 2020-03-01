//
//  CategoryService.swift
//  SpotifyClone
//
//  Created by Lee Bennett on 1/9/20.
//  Copyright © 2020 MadeSimple. All rights reserved.
//

import Foundation

class CategoryService{
    static let shared = CategoryService()
    
    let categories: [Category]
    
    private init(){
        let categoriesUrl = Bundle.main.url(forResource: "categories", withExtension: "json")!
        let data = try! Data(contentsOf: categoriesUrl)
        let decoder = JSONDecoder()
        categories = try! decoder.decode([Category].self, from: data)
    }
}
