//
//  Services.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import Foundation
import RxSwift
import Moya

// Used with navigation controller as dependency injection
protocol HasCategoryServices {
    var categoryServices: CategoryServices { get }
}

class CategoryServices: BaseServices {
    
    // Categories
    func getCategories() -> Observable<CategoryData> {
        let endpoint = ServiceAPI.getCategories()
        return provider.request(MultiTarget(endpoint)).asObservable().map(CategoryData.self).flatMap({ (data) -> Observable<CategoryData> in
            return Observable.just(data)
        })
    }
}


/* -------------- */



// Used with navigation controller as dependency injection
protocol HasProductServices {
    var productServices: ProductServices { get }
}

class ProductServices: BaseServices {
    
    // Products for category
    func postProducts(_ ctegoryID: Int) -> Observable<ProductData> {
        let endpoint = ServiceAPI.postProducts(ctegoryID)
        return provider.request(MultiTarget(endpoint)).asObservable().map(ProductData.self).flatMap({ (data) -> Observable<ProductData> in
            return Observable.just(data)
        })
    }
    
    // Product detail
    func getProductDetail(_ id: Int) -> Observable<ProductDetailData> {
        let endpoint = ServiceAPI.getProductDetail(id)
        return provider.request(MultiTarget(endpoint)).asObservable().map(ProductDetailData.self).flatMap({ (data) -> Observable<ProductDetailData> in
            return Observable.just(data)
        })
    }
}
