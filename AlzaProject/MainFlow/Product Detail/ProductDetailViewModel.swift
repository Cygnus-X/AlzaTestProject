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
    // Do additional model stuff
    
    typealias Dependencies = HasProductServices
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension ProductDetailViewModel: ViewModelType {
    
    // Inputs
    struct Input {
        let getProduct : Observable<Int>
    }
    
    // Outputs
    struct Output {
        let productDetail : Observable<ProductDetailData>
    }
    
    // Collecting Inputs producing Outputs
    func transform(input: ProductDetailViewModel.Input) -> ProductDetailViewModel.Output {
        let requestProducts = input.getProduct
        let products = requestProducts.flatMap { (id)  -> Observable<ProductDetailData> in
            return self.dependencies.productServices.getProductDetail(id)
        }
        
        return Output(productDetail: products)
    }
}
