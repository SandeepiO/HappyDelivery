//
//  WebServicesTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 01/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
import Alamofire
import OHHTTPStubs

@testable import HappyDelivery

class WebServicesTest: XCTestCase {
    
    let host = "mock-api-mobile.dev.lalamove.com"
    
    func testDeliveryListResponse() {
        
        stub(condition: isHost(host)) { (request) -> OHHTTPStubsResponse in
            
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("Delivery.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type": "application/json"]
            )
            
        }
        
        let resultExpectation = expectation(description: "Invalid Json")
        
        let requestModel = DeliveryListRequestModel.Builder()
            .offset(index: 0)
            .limit(index: kListLimit)
            .build()
        
        WebServices.shared.requestForGetType(url: requestModel.deliveryList(), parameters: requestModel.requestBody as [NSString: NSObject], { (response) in
            
            XCTAssertNotNil(response, "Delivery List fetched")
            XCTAssertEqual(20, (response as? NSArray)?.count ?? 0)
            resultExpectation.fulfill()
            
        }, { (error) in
            
            XCTAssertNotNil(error.localizedDescription, "Delivery List not fetched")
            resultExpectation.fulfill()
            
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTAssertNotNil(error, "Request timed out")
            }
        }
        
        OHHTTPStubs.removeAllStubs()
        
    }
    
    func testDeliveryListInvalidResponse() {
        
        stub(condition: isHost(host)) { (request) -> OHHTTPStubsResponse in
            
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("InvalidDelivery.json", type(of: self))!,
                statusCode: 1000,
                headers: ["Content-Type": "application/json"]
            )
            
        }
        
        let resultExpectation = expectation(description: "Delivery List Data")
        
        let requestModel = DeliveryListRequestModel.Builder()
            .offset(index: 0)
            .limit(index: kListLimit)
            .build()
        
        WebServices.shared.requestForGetType(url: requestModel.deliveryList(), parameters: requestModel.requestBody as [NSString: NSObject], { (response) in
            
            XCTAssertNotNil(response, "Delivery List not fetched")
            resultExpectation.fulfill()
            
        }, { (error) in
            
            XCTAssertNotNil(error.localizedDescription, "Invalid Json")
            resultExpectation.fulfill()
            
        })
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTAssertNotNil(error, "Request timed out")
            }
        }
        
        OHHTTPStubs.removeAllStubs()
        
    }
    
}
