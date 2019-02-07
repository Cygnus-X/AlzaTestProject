//
//  MainFlowController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 07/02/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit

class HomeFlowController {
    
    fileprivate let navigationController: UINavigationController
    
    fileprivate let dependencies: AppDependency
    
    init(navigationController: UINavigationController, dependencies: AppDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        if let home = storyboard.instantiateInitialViewController() as? HomeViewController {
            home.flowDelegate = self
            home.homeViewModel = HomeViewModel(dependencies: dependencies)
            navigationController.viewControllers = [home]
        }
    }
}

extension HomeFlowController: HomeFlowDelegate {
    
}
