//
//  XCTest_WebService.swift
//  TCSTEstTests
//
//  Created by Virant Porwal on 02/07/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import XCTest
@testable import TCSTEst

class XCTest_WebService: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCityService() {
        let promise = expectation(description: "Simple Request")
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else { return }
        let webservise = Webservice()
        webservise.getCityDetails(url: url) { error,cityDetailModel  in
            XCTAssertNotNil(cityDetailModel, "No city result")
            promise.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}
