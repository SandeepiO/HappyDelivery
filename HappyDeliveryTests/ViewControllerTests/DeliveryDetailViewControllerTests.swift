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
        deliveryDetailVC = DeliveryDetailViewController(model: DeliveryListModel(dictionary: [:])!)
    }
    
    func testMapViewDelegateConformance() {
        XCTAssertTrue(deliveryDetailVC.conforms(to: MKMapViewDelegate.self))
    }
    
    func testNotNilElements() {
        XCTAssertNil(deliveryDetailVC.title)
        deliveryDetailVC.setUpUI()
        XCTAssertNotNil(deliveryDetailVC.title)
        XCTAssertNotNil(deliveryDetailVC.descriptionLabel)
        XCTAssertNotNil(deliveryDetailVC.mapView)
        XCTAssertNotNil(deliveryDetailVC.bottomView)
    }
    
    override func tearDown() {
        deliveryDetailVC = nil
    }
    
}
