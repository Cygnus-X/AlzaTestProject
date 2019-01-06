//
//  ProductsViewController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

class ProductsViewController: UIViewController {
    
    var category : Category? {
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
        setupViewModel()
    }
    let disposeBag : DisposeBag = DisposeBag()
    
    let productViewModel : ProductViewModel = ProductViewModel(services: Services())
    let productsSubject: PublishSubject<Int> = PublishSubject<Int>()
    
    @IBOutlet weak var tableView: UITableView!
    
    var sourceData : Array<Product> = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    func setupViewModel() {
        let productInput = ProductViewModel.Input(getProducts: productsSubject)
        
        let output = productViewModel.transform(input: productInput)
        output.products
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data) -> () in
                self?.sourceData = data.data
            }).disposed(by: disposeBag)
        
        if let categoryID = category?.id {
            productsSubject.onNext(categoryID)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let productDetailVC = segue.destination as? ProductDetailViewController, let product = sender as? Product {
            productDetailVC.product = product
        }
    }
    
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = sourceData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.price
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = sourceData[indexPath.row]
        performSegue(withIdentifier: "show\(ProductDetailViewController.nameOfClass)", sender: product)
    }
}
