//
//  CoreDataTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 01/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
import CoreData
@testable import HappyDelivery

class CoreDataTests: XCTestCase {
    
    override func setUp() {
        CoreDataHelper.shared.managedContext = CoreDataMock().mockPersistantContainer.viewContext
    }
    
    func testCheckDeliveryListItem() {
        let dictionary: NSDictionary = ["id": 0]
        CoreDataHelper.shared.save(deliveryList: [DeliveryListModel(dictionary: dictionary)!])
        XCTAssertTrue(CoreDataHelper.shared.deliveryEntityExists(id: 0))
    }
    
    func testAddDeliveryList() {
        let dictionary: NSDictionary = ["id": 0]
        CoreDataHelper.shared.save(deliveryList: [DeliveryListModel(dictionary: dictionary)!])
        XCTAssertTrue(CoreDataHelper.shared.getDeliveryListData(offset: 0, limit: 20).count == 1)
    }

    func testExistedData() {
        XCTAssertFalse(CoreDataHelper.shared.deliveryEntityExists(id: 0))
        let dictionary: NSDictionary = ["id": 0]
        CoreDataHelper.shared.save(deliveryList: [DeliveryListModel(dictionary: dictionary)!])
        XCTAssertTrue(CoreDataHelper.shared.deliveryEntityExists(id: 0))
    }

    func testEmptyData() {
        XCTAssertTrue(CoreDataHelper.shared.getDeliveryListData(offset: 0, limit: 20).count == 0)
    }

    override func tearDown() {
        super.tearDown()
    }

}
