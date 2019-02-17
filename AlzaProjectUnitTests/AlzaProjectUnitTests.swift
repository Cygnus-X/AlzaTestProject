//
//  AlzaProjectUnitTests.swift
//  AlzaProjectUnitTests
//
//  Created by Viktor Kaderabek on 17/02/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//

import XCTest
import Moya
@testable import AlzaProject

class AlzaProjectUnitTests: XCTestCase {
    let dependencies = AppDependency(categoryServices: CategoryServices(), productServices: ProductServices())

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func testHomeViewModel() {
        
        let homeVM = HomeViewModel(dependencies: dependencies)
        XCTAssert(homeVM.dependencies != nil)
        
        
        let expectation = self.expectation(description: "Execute the call related to functionality X")
        
        class IntegrationTestMockPlugin: PluginType {
            
            func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
                
                guard let apiTarget = target as? APIService, case .expectedTarget = apiTarget else {
                    XCTFail("did hit an unexpected target")
                }
                expectation?.fulfill()
            }
        }
        
        let integrationTestPlugin = IntegrationTestMockPlugin()
        let stubbingProvider = MoyaProvider<APIService>(stubClosure: MoyaProvider.immediatelyStub, plugins: [integrationTestPlugin])
        
        ...
        
        func testIntegration() {
            // execute your app’s functionality, and by the time it is expected to be completed, just run:
            self.waitForExpectations(timeout: 50.0, handler: nil)
        }
    }

}
