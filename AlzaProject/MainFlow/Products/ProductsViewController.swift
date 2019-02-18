//
//  ProductsViewController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

protocol ProductsFlowDelegate {
    func showDetailOf(product: Product)
}

class ProductsViewController: BaseViewController {
    
    // Flow Control
    var flowDelegate: ProductsFlowDelegate?
    var viewModel : ProductsViewModel?
    
    // Outlets
    var category : ProductCategory? {
        didSet {
            if let categoryID = category?.id {
                productsSubject.onNext(categoryID)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = category?.name
        // Do any additional setup after loading the view.
    }
    
//    let productViewModel : ProductViewModel = ProductViewModel()
    let productsSubject: PublishSubject<Int> = PublishSubject<Int>()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: ProductTableViewCell.nameOfClass, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.nameOfClass)
        }
    }
    
    var sourceData : Array<Product> = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        
        // Collecting Inputs
        let productInput = ProductsViewModel.Input(getProducts: productsSubject)
        
        // Subscribing Outputs
        guard let output = viewModel?.transform(input: productInput) else {
            return
        }
        
        output.products
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data) -> () in
                self?.sourceData = data.data
            }).disposed(by: disposeBag)
        
        if let categoryID = category?.id {
            productsSubject.onNext(categoryID)
        }
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = sourceData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.nameOfClass, for: indexPath) as! ProductTableViewCell
        cell.nameLabel.text = product.name
        cell.priceLabel.text = product.price
        cell.specLabel.text = product.spec
        if let url = URL(string: product.img) {
            cell.productImageView?.af_setImage(withURL: url)
        }
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // product selected
        let product = sourceData[indexPath.row]
        flowDelegate?.showDetailOf(product: product)
    }
}
