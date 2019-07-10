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
    
    override func setUp() {
        deliveryListViewController = DeliveryListViewController()
        deliveryListViewController.dataManager = DataManagerMock()
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
        (deliveryListViewController.dataManager.webService as? WebServicesMock)?.isError = false
        deliveryListViewController.getDeliveryListFromServer()
        XCTAssert(deliveryListViewController.deliveryList.count == 1)
    }

    func testGetDeliveryListFromServerError() {
        (deliveryListViewController.dataManager.webService as? WebServicesMock)?.isError = true
        deliveryListViewController.getDeliveryListFromServer()
        XCTAssert(deliveryListViewController.deliveryList.count == 0)
    }

    func testGetDeliveryListNexPageDataFromServerSuccess() {
        (deliveryListViewController.dataManager.webService as? WebServicesMock)?.isError = false
        deliveryListViewController.getDeliveryListNextPageData()
        XCTAssert(deliveryListViewController.deliveryList.count == 1)
    }

    func testGetDeliveryListNextPageDataFromServerError() {
        (deliveryListViewController.dataManager.webService as? WebServicesMock)?.isError = true
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
    }

}
