//
//  AppFlowController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 07/02/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit

class AppFlowController {
    
    fileprivate let window: UIWindow
    
    fileprivate let dependencies: AppDependency
    
    init(window: UIWindow) {
        self.window = window
        dependencies = AppDependency(categoryServices: CategoryServices(),
                                     productServices: ProductServices())
    }
    
    func start() {
        let navController = UINavigationController()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        let flowController = HomeFlowController(navigationController: navController, dependencies: dependencies)
        flowController.start()
    }
}
