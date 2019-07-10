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
    
    override init() {
        super.init()
        CoreDataHelper.shared.managedContext = CoreDataMock().mockPersistantContainer.viewContext
        self.webService = WebServicesMock()
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
        let requestModel = generateRequestModel(offset: offset, limit: limit, isToPullRefresh: isToPullRefresh)
        webService.requestForGetType(url: requestModel.deliveryListUrl(), parameters: requestModel.requestBody as [NSString: NSObject]) { (response, error) in
            if let error = error {
                responseBlock?(nil, error)
            } else {
                let deliveryLists = ModelConversion.arrayModelFromDictionary(array: response as? NSArray ?? [])
                responseBlock?(deliveryLists, nil)
            }
        }
    }

}
