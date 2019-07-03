//
//  DeliveryListModelTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 02/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
@testable import HappyDelivery

class DeliveryListModelTests: XCTestCase {
    
    override func setUp() {
        
    }
    
    func testDeliveryListResponseModel() {
        
        let dict: NSDictionary? = ["location": NSDictionary()]
        
        XCTAssertNotNil(DeliveryListModel(dictionary: dict ?? [:]))
        
    }
    
    func testArrayDeliveryListResponseModel() {
        
        var array = NSMutableArray()
        
        for _ in 0..<10 {
            
            let dict: NSDictionary? = ["location": NSDictionary()]
            
            array.add(dict)
            
        }
        
        XCTAssertNotNil(DeliveryListModel.arrayModelFromDictionary(array: array))
        
    }
    
    override func tearDown() {
        
    }
    
}
