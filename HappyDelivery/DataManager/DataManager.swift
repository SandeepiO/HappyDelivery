//
//  DataManager.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 04/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation

class DataManager {

    var webService: WebServices = WebServices()

    func getDeliveriesListFromCoreData(offset: Int, limit: Int) -> [DeliveryListModel] {
        let deliveriesList = CoreDataHelper.shared.getDeliveryListData(offset: offset, limit: limit)
        return deliveriesList
        
    }
    
    func generateRequestModel(offset: Int, limit: Int, isToPullRefresh: Bool? = false) -> DeliveryListRequestModel {
        let requestModel = DeliveryListRequestModel.Builder()
            .offset(index: isToPullRefresh == false ? offset : kStartOffset)
            .limit(index: limit)
            .build()
        return requestModel
    }
    
    func getDeliveryListFromServer(offset: Int, limit: Int, isToPullRefresh: Bool? = false, responseBlock: ((_ deliveryList: [DeliveryListModel]?, _ error: Error?) -> Void)?) {
        let requestModel = generateRequestModel(offset: offset, limit: limit, isToPullRefresh: isToPullRefresh)
        
        webService.requestForGetType(url: requestModel.deliveryListUrl(), parameters: requestModel.requestBody as [NSString: NSObject], {(response, error)  in
            if error == nil {
                let deliveryLists = ModelConversion.arrayModelFromDictionary(array: response as? NSArray ?? [])
                responseBlock?(deliveryLists, nil)
            } else {
                responseBlock?(nil, error)
            }
        })
    }
    
}
