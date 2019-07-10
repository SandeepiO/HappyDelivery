//
//  WebServicesMock.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 04/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation
@testable import HappyDelivery

class WebServicesMock: WebServices {

    var isError = false

    override func requestForGetType(url: String, parameters: [NSString: NSObject], _ responseBlock: @escaping ((Any?, Error?) -> Void)) {
        if isError {
            let error = NSError(domain: "Custom Error", code: 500, userInfo: nil)
            responseBlock(nil, error)
        } else {
            let location: NSDictionary = ["lat": 28.23, "lng": 78.00, "address": "address"]
            let deliveryItem: NSDictionary = ["id": 0, "imageUrl": "", "description": "sddsad", "location": location]
            responseBlock([deliveryItem], nil)
        }
    }

}
