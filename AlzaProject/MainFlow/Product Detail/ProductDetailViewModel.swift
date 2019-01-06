//
//  ProductDetailViewModel.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 07/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

class ProductDetailViewModel: BaseViewModel {
    var services : Services!
    
    init(services: Services) {
        self.services = services
    }
    
    func transform(input: ProductDetailViewModel.Input) -> ProductDetailViewModel.Output {
        let requestProducts = input.getProduct
        let products = requestProducts.flatMap { (id)  -> Observable<ProductDetailData> in
            return self.services.getProductDetail(id)
        }
        
        return Output(productDetail: products)
    }
}

extension ProductDetailViewModel {
    struct Input {
        let getProduct : Observable<Int>
    }
    struct Output {
        let productDetail : Observable<ProductDetailData>
    }
}
