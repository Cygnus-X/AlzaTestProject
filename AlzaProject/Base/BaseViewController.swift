//
//  BaseViewController.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 08/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    // Disposing all observables once the deinit() is called
    let disposeBag : DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupViewModel()
    }
    
    func setupViewModel() {
        // to be overridden in subclasses
    }
}
