//
//  DeliveryDetailViewControllerTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 01/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
import MapKit
@testable import HappyDelivery

class DeliveryDetailViewControllerTests: XCTestCase {
    
    var deliveryDetailVC: DeliveryDetailViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class
        deliveryDetailVC = DeliveryDetailViewController(model: DeliveryListModel(dictionary: [:])!)
        deliveryDetailVC.viewDidLoad()
        
    }
    
    func testMapViewDelegateConformance() {
        XCTAssertTrue(deliveryDetailVC.conforms(to: MKMapViewDelegate.self))
    }
    
    func testNotNilElements() {
        
        XCTAssertNotNil(deliveryDetailVC.title)
        XCTAssertNotNil(deliveryDetailVC.deliveryListData)
        XCTAssertNotNil(deliveryDetailVC.mapView)
        XCTAssertNotNil(deliveryDetailVC.bottomView)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
