//
//  ServicesAPI.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift
import Moya

enum ServiceAPI {
    case getCategories()
    case postProducts(_ categoryID: Int)
    case getProductDetail(_ id: Int)
}

extension ServiceAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(NetworkingConstants.baseUrl)")!
    }
    var path: String {
        switch self {
        case .getCategories:
            return "/v1/floors"
        case .postProducts:
            return "/v2/products"
        case .getProductDetail(let id):
            return "/v9/product/\(id)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .postProducts:
            return .post
        default:
            return .get
        }
    }
    var headers: [String : String]? {
        return nil
    }
    var task: Task {
        switch self {
        case .postProducts(let categoryID):
            let filterParams : [String : Any] = [
                "id" : categoryID
            ]
            let params: [String : Any] = [
                "filterParameters" : filterParams
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .getProductDetail:
            return NetworkingUtilities.stubbedResponse("ProductDetail")
        case .getCategories:
            return NetworkingUtilities.stubbedResponse("ProductCategory")
        case .postProducts:
            return NetworkingUtilities.stubbedResponse("Product")
        }
    }
}
