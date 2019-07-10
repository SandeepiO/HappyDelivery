//
//  ModelConversion.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 04/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation
import CoreData

class ModelConversion {
    
    class func arrayModelFromDictionary(array: NSArray) -> [DeliveryListModel] {
        var deliveryListModel: [DeliveryListModel] = []
    
        for data in array {
            if let dataModel = data as? NSDictionary {
                let model = DeliveryListModel(dictionary: dataModel)!
                deliveryListModel.append(model)
            }
        }
        return deliveryListModel
    }

    class func arrayModelFromManagedObject(array: [NSManagedObject]) -> [DeliveryListModel] {
        var deliveryListModel: [DeliveryListModel] = []
        
        for data in array {
            let model = DeliveryListModel(data: data)!
            deliveryListModel.append(model)
        }
        return deliveryListModel
    }
    
}
