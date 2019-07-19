//
//  ViperStoreTests.swift
//  ViperStoreTests
//
//  Created by Varun Rathi on 19/07/19.
//  Copyright © 2019 Varun Rathi. All rights reserved.
//

import XCTest
@testable import ViperStore

class ViperStoreTests: XCTestCase {

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
    
    
    func testFetchProducts(){
        let datamanager = ListDataManager()
        let interactor = ListInteractor(dataManager: datamanager)
        interactor.fetchProductsFromStore()
        let products = interactor.products.value
        XCTAssert( products.count > 0, "Zero products loaded")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
