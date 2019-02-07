//
//  HomeViewController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeFlowDelegate: class {
    
}

class HomeViewController: BaseViewController {
    
    // Flow Control
    weak var flowDelegate: HomeFlowDelegate?
    var homeViewModel : HomeViewModel?
    
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
        
        let categoriesInput = HomeViewModel.Input(getCategories: categoriesSubject)
        
        guard let output = homeViewModel?.transform(input: categoriesInput) else {
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let productsVC = segue.destination as? ProductsViewController, let category = sender as? Category {
            productsVC.category = category
        }
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
        let category = sourceData[indexPath.row]
        
        // category selected
        performSegue(withIdentifier: "show\(ProductsViewController.nameOfClass)", sender: category)
    }
}

