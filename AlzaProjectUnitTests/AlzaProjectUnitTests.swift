//
//  AlzaProjectUnitTests.swift
//  AlzaProjectUnitTests
//
//  Created by Viktor Kaderabek on 17/02/2019.
//  Copyright © 2019 CygnusX. All rights reserved.
//



import XCTest
import RxSwift
import RxCocoa
import RxTest
import Moya
@testable import AlzaProject

class AlzaProjectUnitTests: XCTestCase {
    var dependencies : AppDependency?
    var homeViewModel: HomeViewModel?
    var scheduler: ConcurrentDispatchQueueScheduler!
    
    let provider = MoyaProvider<ServiceAPI>(stubClosure: MoyaProvider.immediatelyStub)
    
    override func setUp() {
        super.setUp()
        
        dependencies = AppDependency(categoryServices: CategoryServices(), productServices: ProductServices())
        XCTAssert(dependencies != nil)
        
        homeViewModel = HomeViewModel(dependencies: dependencies!)
        XCTAssert(homeViewModel != nil)
        
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }
    
    func testGetCategory() {
        let url = provider.endpoint(ServiceAPI.getCategories()).url
        XCTAssertEqual(url, "https://www.alza.cz/Services/RestService.svc/v1/floors")
        
        let disposeBag = DisposeBag()
        
        let expect = expectation(description: #function)
        var result : [Any]?
        
        let publishSubject = PublishSubject<Void>()
        let input = HomeViewModel.Input(getCategories: publishSubject)
        let output = homeViewModel?.transform(input: input)
        
        XCTAssert(output != nil)

        output?.categories.subscribe(onNext: { categories in
            result = categories.data
            expect.fulfill()
        }).disposed(by: disposeBag)
        
        publishSubject.onNext(())
        
        waitForExpectations(timeout: 30.0) { error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
    
            XCTAssert(result?.count ?? 0 > 0)
            XCTAssert(result?.first is ProductCategory)
        }

        
    }
    
    func testPostProducts() {
        let category : Int = 1
        let endpoint = provider.endpoint(ServiceAPI.postProducts(category))
        XCTAssertEqual(endpoint.url, "https://www.alza.cz/Services/RestService.svc/v2/products")
        
        var product: String?
    
        let target = ServiceAPI.postProducts(category)
        provider.request(target) { result in
            if case let .success(response) = result {
                product = String(data: response.data, encoding: .utf8)
            } else {
                XCTFail()
            }
        }
        
        XCTAssert(product != nil)
        
        let sampleData = target.sampleData
        XCTAssertEqual(String(data: sampleData, encoding: .utf8), product)
        
    }
}
