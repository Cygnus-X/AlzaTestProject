//
//  HomeViewModel.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewModel: BaseViewModel {
    // Do additional model stuff
    
    typealias Dependencies = HasCategoryServices
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension HomeViewModel: ViewModelType {
    
    // Inputs
    struct Input {
        let getCategories : Observable<()>
    }
    
    // Outputs
    struct Output {
        let categories : Observable<CategoryData>
    }
    
    // Collecting Inputs producing Outputs
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
        let requestCategories = input.getCategories
        let categories = requestCategories.flatMap { (_)  -> Observable<CategoryData> in
            return self.dependencies.categoryServices.getCategories()
        }
        
        return Output(categories: categories)
    }
}
