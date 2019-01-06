//
//  NSObject+Ext.swift
//  AlzaProject
//
//  Created by Viktor Kaderabek on 06/01/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import Foundation

extension NSObject {
    
    /// class name literal
    public class var nameOfClass: String {
        get {
            guard let className = NSStringFromClass(self).components(separatedBy: ".").last else {
                return "N/A"
            }
            return className
        }
    }
}
