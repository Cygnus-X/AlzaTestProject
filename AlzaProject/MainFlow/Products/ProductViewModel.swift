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
    var services : Services!
    
    init(services: Services) {
        self.services = services
    }
    
    
    func transform(input: ProductViewModel.Input) -> ProductViewModel.Output {
        let requestProducts = input.getProducts
        let products = requestProducts.flatMap { (id)  -> Observable<ProductData> in
            return self.services.postProducts(id)
        }
        
        return Output(products: products)
    }
}

extension ProductViewModel {
    struct Input {
        let getProducts : Observable<Int>
    }
    struct Output {
        let products : Observable<ProductData>
    }
}
