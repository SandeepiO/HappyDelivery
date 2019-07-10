//
//  ApiManagerTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 04/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import HappyDelivery

class DataManagerTests: XCTestCase {
    
    var dataManager: DataManager!
    var webServices: WebServicesMock!
    
    override func setUp() {
        CoreDataHelper.shared.managedContext = CoreDataMock().mockPersistantContainer.viewContext
        dataManager = DataManager()
        webServices = WebServicesMock()
        dataManager.webService = webServices
    }
    
    func testGetDeliveriesListEmpty() {
        XCTAssertTrue(dataManager.getDeliveriesListFromCoreData(offset: 0, limit: 20).count == 0)
    }

    func testGetDeliveryListSuccess() {
        CoreDataHelper.shared.save(deliveryList: [DeliveryListModel(dictionary: ["id": 0])!])
        XCTAssertTrue(dataManager.getDeliveriesListFromCoreData(offset: 0, limit: 20).count == 1)
    }
    
    func testGenerateRequestModel() {
        XCTAssertNotNil(dataManager.generateRequestModel(offset: 0, limit: 0, isToPullRefresh: false))
    }
    
    func testgetDeliveryListFromServerSuccess() {
        webServices.isError = false
        dataManager.getDeliveryListFromServer(offset: kStartOffset, limit: kListLimit, responseBlock: { (deliveryList, error) in
            XCTAssertNil(error?.localizedDescription)
            XCTAssertTrue(deliveryList?.count == 1)
        })
    }

    func testgetDeliveryListFromServerError() {
        webServices.isError = true
        dataManager.getDeliveryListFromServer(offset: kStartOffset, limit: kListLimit, responseBlock: { (deliveryList, error) in
            XCTAssertNotNil(error?.localizedDescription)
            XCTAssertNil(deliveryList)
        })
    }

    override func tearDown() {
        super.tearDown()
        dataManager = nil
        webServices = nil
    }

}
