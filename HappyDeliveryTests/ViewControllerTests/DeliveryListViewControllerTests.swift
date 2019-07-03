//
//  DeliveryListViewControllerTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 01/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
@testable import HappyDelivery

class DeliveryListViewControllerTests: XCTestCase {
    
    var deliveryListViewController: DeliveryListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let navigationController = UIApplication.shared.delegate?.window??.rootViewController as! UINavigationController
        deliveryListViewController = navigationController.viewControllers.first as? DeliveryListViewController
    }
    
    func testTableViewDelegateConformance() {
        XCTAssertTrue(deliveryListViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(deliveryListViewController.title)
        XCTAssertNotNil(deliveryListViewController.tableView)
    }
    
    func testGetDeliveryList() {
        
        XCTAssertNotNil(deliveryListViewController.getDeliveryList())
        XCTAssertNotNil(deliveryListViewController.getNextPageData())
        
    }
    
    func testShowAlert() {
        
        XCTAssertNoThrow(deliveryListViewController.showAlert("", nil))
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}
