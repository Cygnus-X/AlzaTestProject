//
//  HomeViewController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeFlowDelegate {
    func showProductsFor(category: Category)
}

class HomeViewController: BaseViewController {
    
    // Flow Control
    var flowDelegate: HomeFlowDelegate?
    var viewModel : HomeViewModel?
    
    // Outlets
    let categoriesSubject: PublishSubject<()> = PublishSubject<()>()
    
    @IBOutlet weak var tableView: UITableView!

    var sourceData : Array<Category> = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func setupViewModel() {
        super.setupViewModel()
        
        // Collecting Inputs
        let categoriesInput = HomeViewModel.Input(getCategories: categoriesSubject)
        
        // Subscribing Outputs
        guard let output = viewModel?.transform(input: categoriesInput) else {
            return
        }
        
        output.categories
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (data) -> () in
                self?.sourceData = data.data
            }).disposed(by: disposeBag)
        
        // trigger get categories
        categoriesSubject.onNext(())
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = sourceData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = category.name
//        cell.detailTextLabel?.text = "\(category.child_cnt)"
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // category selected
        let category = sourceData[indexPath.row]
        flowDelegate?.showProductsFor(category: category)
    }
}

