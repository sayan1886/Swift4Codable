//
//  RepliconTestTests.swift
//  RepliconTestTests
//
//  Created by Sayan Chatterjee on 12/03/18.
//  Copyright © 2018 Vaoprware Solutions. All rights reserved.
//

import XCTest
@testable import RepliconTest

class RepliconTestTests: XCTestCase {
    
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
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testAppManager () {
        let expec = expectation(description: "Get some Photos!")
        let client = AppManager.sharedInstance

        client.getAllPhotosFromRemote { (status :Dictionary<String, Any>) in
            let downloadStatus = status["status"] as! String
            if downloadStatus == CompletionStatus.Success.rawValue {
                expec.fulfill()
            }
            else {
                XCTFail("Expected photos to succeed, but it failed. ?")
            }
        }
        waitForExpectations(timeout : 10, handler: nil)
    }
    
}
