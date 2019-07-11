//
//  DeliveryListViewControllerTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 01/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import HappyDelivery

class DeliveryListViewControllerTests: XCTestCase {
    
    var deliveryListViewController: DeliveryListViewController!
    var dataManager: DataManagerMock!
    
    override func setUp() {
        deliveryListViewController = DeliveryListViewController()
        dataManager = DataManagerMock()
        deliveryListViewController.dataManager = dataManager
    }
    
    func testTableViewDelegateConformance() {
        XCTAssertTrue(deliveryListViewController.conforms(to: UITableViewDelegate.self))
    }
    
    func testRequiredElementShouldNotNil() {
        XCTAssertNotNil(deliveryListViewController.tableView)
        XCTAssertNil(deliveryListViewController.title)
        deliveryListViewController.setUpUI()
        XCTAssertNotNil(deliveryListViewController.title)
    }
    
    func testGetDeliveryListFromServerSuccess() {
        dataManager.isError = false
        deliveryListViewController.getDeliveryListFromServer()
        XCTAssert(deliveryListViewController.deliveryList.count == 1)
    }

    func testGetDeliveryListFromServerError() {
        dataManager.isError = true
        deliveryListViewController.getDeliveryListFromServer()
        XCTAssert(deliveryListViewController.deliveryList.count == 0)
    }

    func testGetDeliveryListNexPageDataFromServerSuccess() {
        dataManager.isError = false
        deliveryListViewController.getDeliveryListNextPageData()
        XCTAssert(deliveryListViewController.deliveryList.count == 1)
    }

    func testGetDeliveryListNextPageDataFromServerError() {
        dataManager.isError = true
        deliveryListViewController.getDeliveryListNextPageData()
        XCTAssert(deliveryListViewController.deliveryList.count == 0)
    }

    func testGetNextPageDataWithCoreDataEmpty() {
        deliveryListViewController.getNextPageData()
        XCTAssertTrue(deliveryListViewController.deliveryList.count == 0)
    }

    func testGetDeliveryListWithCoreDataValue() {
        CoreDataHelper.shared.save(deliveryList: [DeliveryListModel(dictionary: ["id": 0]) ?? DeliveryListModel(dictionary: [:])!])
        deliveryListViewController.getNextPageData()
        XCTAssertTrue(deliveryListViewController.deliveryList.count == 1)

    }
    
    override func tearDown() {
        super.tearDown()
        deliveryListViewController = nil
        dataManager = nil
    }

}
