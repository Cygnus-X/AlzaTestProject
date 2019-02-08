//
//  ProductDetailViewController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 08/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift
import AlamofireImage

protocol ProductDetailFlowDelegate {
    
}

class ProductDetailViewController: BaseViewController {
   
    // Flow Control
    var flowDelegate: ProductDetailFlowDelegate?
    var viewModel : ProductDetailViewModel?
    
    // Outlets
    var product : Product? {
        didSet {
            if let productID = product?.id {
                productDetailSubject.onNext(productID)
            }
        }
    }
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = product?.name
        // Do any additional setup after loading the view.
    }
    
//    let productDetailViewModel : ProductDetailViewModel = ProductDetailViewModel()
    let productDetailSubject: PublishSubject<Int> = PublishSubject<Int>()
    
    override func setupViewModel() {
        super.setupViewModel()
        
        // Collecting Inputs
        let productDetailInput = ProductDetailViewModel.Input(getProduct: productDetailSubject)
        
        // Subscribing Outputs
        guard let output = viewModel?.transform(input: productDetailInput) else {
            return
        }
        
        output.productDetail
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data) -> () in
                self?.populate(with: data.data)
            }).disposed(by: disposeBag)
        
        // get product detail
        if let productID = product?.id {
            productDetailSubject.onNext(productID)
        }
    }
    
    fileprivate func populate(with productDetail: ProductDetail) {
        if let imageUrl = productDetail.imgs.first?.origUrl,
            let url = URL(string: imageUrl) {
            productImageView.af_setImage(withURL: url)
        }
        
        productTitleLabel.text = productDetail.name
    }
}
