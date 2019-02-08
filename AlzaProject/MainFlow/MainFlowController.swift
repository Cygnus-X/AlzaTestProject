//
//  MainFlowController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 07/02/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit

class MainFlowController {
    
    fileprivate let navigationController: UINavigationController
    fileprivate let dependencies: AppDependency
    
    init(navigationController: UINavigationController, dependencies: AppDependency) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let storyboard = UIStoryboard(name: HomeViewController.nameOfStoryboard, bundle: nil)
        if let home = storyboard.instantiateInitialViewController() as? HomeViewController {
            home.flowDelegate = self
            home.viewModel = HomeViewModel(dependencies: dependencies)
            navigationController.viewControllers = [home]
        }
    }
}

extension MainFlowController: HomeFlowDelegate {
    func showProductsFor(category: Category) {
        let storyboard = UIStoryboard(name: ProductsViewController.nameOfStoryboard, bundle: nil)
        
        if let products = storyboard.instantiateInitialViewController() as? ProductsViewController {
            products.flowDelegate = self
            products.viewModel = ProductsViewModel(dependencies: dependencies)
            products.category = category
            navigationController.show(products, sender: nil)
        }
    }
}

extension MainFlowController: ProductsFlowDelegate {
    func showDetailOf(product: Product) {
        let storyboard = UIStoryboard(name: ProductDetailViewController.nameOfStoryboard, bundle: nil)
        
        if let productDetail = storyboard.instantiateInitialViewController() as? ProductDetailViewController {
            productDetail.flowDelegate = self
            productDetail.viewModel = ProductDetailViewModel(dependencies: dependencies)
            productDetail.product = product
            navigationController.show(productDetail, sender: nil)
        }
    }
}

extension MainFlowController: ProductDetailFlowDelegate {
    
}
