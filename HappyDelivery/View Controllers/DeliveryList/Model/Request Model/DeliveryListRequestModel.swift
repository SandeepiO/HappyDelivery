//
//  DeliveryListRequestModel.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation

class DeliveryListRequestModel {
    
    struct ApiKeys {
        static let offset = "offset"
        static let limit = "limit"
    }
    
    var requestBody: [String: NSObject] = [:]
    
    init(builder: Builder) {
        self.requestBody = builder.requestBody
    }
    
    internal class Builder {
    
        var requestBody: [String: NSObject] = [:]
        
        func offset(index: Int) -> Builder {
            
            requestBody[ApiKeys.offset] = "\(index)" as NSObject
            
            return self
            
        }
        
        func limit(index: Int) -> Builder {
            
            requestBody[ApiKeys.limit] = "\(index)" as NSObject
            
            return self
            
        }
        
        func build() -> DeliveryListRequestModel {
            return DeliveryListRequestModel(builder: self)
        }
    
    }
    
    func deliveryListUrl() -> String {
        return WebServices.shared.baseUrl + ApiEndPoint().deliveries
        
    }
    
}
