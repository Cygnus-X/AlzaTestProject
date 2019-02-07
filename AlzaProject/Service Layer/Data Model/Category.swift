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
}

struct Category: Codable {
    let id : Int
    let name : String
    let child_cnt : Int
}
