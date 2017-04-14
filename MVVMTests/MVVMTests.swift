//
//  MVVMTests.swift
//  MVVMTests
//
//  Created by lamour  on 4/12/17.
//  Copyright © 2017 lamour . All rights reserved.
//

import XCTest
@testable import MVVM

class MVVMTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        testAsync()
    }
    
    func testAsync() {
        let asyncExpectation = expectation(description: "Getting json Dictionary from REST")
        let endpointString = "http://www.splashbase.co/api/v1/images/1"
        let endpointUrl = URL(string: endpointString)

        let model = Model(withUrl: endpointUrl!)
        
        model.downloadDict{ (dict:Dictionary<String, Any>?) in
             XCTAssertNotNil(dict)
          asyncExpectation.fulfill()
        }
         // after fulfillment
        waitForExpectations(timeout: 1) { (err:Error?) in
            XCTAssertNil(err, "Yikes")
        }
    
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
