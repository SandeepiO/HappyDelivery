//
//  ApiManagerMock.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 05/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation
@testable import HappyDelivery

class DataManagerMock: DataManager {

    var isError = false

    override init() {
        super.init()
        CoreDataHelper.shared.managedContext = CoreDataMock().mockPersistantContainer.viewContext
    }

    override func getDeliveriesListFromCoreData(offset: Int, limit: Int) -> [DeliveryListModel] {
        let deliveriesList = CoreDataHelper.shared.getDeliveryListData(offset: offset, limit: limit)
        return deliveriesList
    }

    override func generateRequestModel(offset: Int, limit: Int, isToPullRefresh: Bool? = false) -> DeliveryListRequestModel {
        let requestModel = DeliveryListRequestModel.Builder()
            .offset(index: isToPullRefresh == false ? offset : kStartOffset)
            .limit(index: limit)
            .build()
        return requestModel
    }

    override func getDeliveryListFromServer(offset: Int, limit: Int, isToPullRefresh: Bool? = false, responseBlock: (([DeliveryListModel]?, Error?) -> Void)?) {
        if isError {
            let error = NSError(domain: "Custom Error", code: 500, userInfo: nil)
            responseBlock?([], error)
        } else {
            let location: NSDictionary = ["lat": 28.23, "lng": 78.00, "address": "address"]
            let deliveryItem: NSDictionary = ["id": 0, "imageUrl": "", "description": "sddsad", "location": location]
            responseBlock?([DeliveryListModel(dictionary: deliveryItem)!], nil)
        }
    }

}
