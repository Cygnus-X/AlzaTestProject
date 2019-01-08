//
//  Product.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import Foundation

struct ProductData: Codable {
    let data : Array<Product>
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct Product: Codable {
    let id : Int
    let name : String
    let price : String
    let spec : String
    let img : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case price
        case spec
        case img
    }
}
