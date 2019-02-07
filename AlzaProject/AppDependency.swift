//
//  AppDependency.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 07/02/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit

struct AppDependency: HasCategoriServices,
                      HasProductServices {
    
    let categoryServices: CategoryServices
    let productServices: ProductServices
}
