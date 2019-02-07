//
//  ProductViewModel.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

class ProductViewModel: BaseViewModel {
    // Do additional model stuff
    
    typealias Dependencies = HasProductServices
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension ProductViewModel: ViewModelType {
    
    // Inputs
    struct Input {
        let getProducts : Observable<Int>
    }
    
    // Outputs
    struct Output {
        let products : Observable<ProductData>
    }
    
    // Collecting Inputs producing Outputs
    func transform(input: ProductViewModel.Input) -> ProductViewModel.Output {
        let requestProducts = input.getProducts
        let products = requestProducts.flatMap { (id)  -> Observable<ProductData> in
            return self.dependencies.productServices.postProducts(id)
        }
        
        return Output(products: products)
    }
}
