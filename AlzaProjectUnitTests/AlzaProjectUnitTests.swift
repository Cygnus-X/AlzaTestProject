//
//  AlzaProjectUnitTests.swift
//  AlzaProjectUnitTests
//
//  Created by Viktor Kaderabek on 17/02/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import XCTest
import Moya
import Result
import RxSwift
@testable import AlzaProject

class AlzaProjectUnitTests: XCTestCase {
    var dependencies : AppDependency!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dependencies = AppDependency(categoryServices: CategoryServices(), productServices: ProductServices())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetCategory() {
        let categories = dependencies.categoryServices.getCategories()
        categories.subscribe(onNext: { data in
            print(data.data.first)
        }).dispose()
    
    }

}
