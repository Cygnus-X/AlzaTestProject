//
//  BaseServices.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class BaseServices: NSObject {
    
    let provider = AuthenticatedProvider<MultiTarget>()
    
}
