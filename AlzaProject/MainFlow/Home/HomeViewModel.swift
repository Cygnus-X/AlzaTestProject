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
            return self.services.getCategories()
        }
        
        return Output(categories: categories)
    }
}
