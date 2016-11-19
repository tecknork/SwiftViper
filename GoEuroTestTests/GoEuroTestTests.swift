//
//  GoEuroTestTests.swift
//  GoEuroTestTests
//
//  Created by Murtaza Raza  on 17/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import XCTest


@testable import GoEuroTest

class GoEuroTestTests: XCTestCase {
    var theExpectation:XCTestExpectation?
    
    var Manager :FetchDataProtocol = NetworkManager()
    

    
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
    
    
    func testFetchData() {
      theExpectation = expectation(description: "initialized")

        
        Manager.fetchDataFromApi(type: .Air) { (error, travelData) in
            if travelData != nil {
                print(travelData!);
                self.theExpectation?.fulfill()
            } else if let error = error {
                print (error);
                  self.theExpectation?.fulfill()
               
            }
        }
        waitForExpectations(timeout: 500, handler: { error in XCTAssertNil(error, "Oh, we got timeout")
        })
        
    }
    
//        Manager.fetchDataFromApi(type: .Air){
//            (error,data) in {
//               
//                if let AirData = data{
//                  print(data!)
//                } else if let error = error {
//                    print(error)
//            }
//        }
//        
//        
//    }
    
    
}
