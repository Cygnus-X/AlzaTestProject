//
//  ProductDetail.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import Foundation

struct ProductDetailData: Codable {
    let data : ProductDetail
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct ProductDetail: Codable {
    let name : String
    let imgs : Array<ProductImages>
    
    enum CodingKeys: String, CodingKey {
        case name
        case imgs
    }
}

struct ProductImages: Codable {
    let origUrl : String
    
    enum CodingKeys: String, CodingKey {
        case origUrl
    }
}
