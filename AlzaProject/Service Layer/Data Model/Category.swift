//
//  Category.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import Foundation

struct CategoryData: Codable {
    let data : Array<Category>
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Category: Codable {
    let id : Int
    let name : String
    let child_cnt : Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case child_cnt
    }
}
