//
//  XCTest_CityViewModel.swift
//  TCSTEstTests
//
//  Created by Virant Porwal on 02/07/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import XCTest
@testable import TCSTEst

class XCTest_CityViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCityModel() {
        
        let viewModel = CityModel(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", image: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        XCTAssertFalse(viewModel.title!.isEmpty)
        XCTAssertEqual(viewModel.title?.count, 7)

    }
    func testInit_CityArrayIsNotNil() {
         let viewModel = CityModel(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony", image: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        XCTAssertNotNil(viewModel.title)
    }
   

}
