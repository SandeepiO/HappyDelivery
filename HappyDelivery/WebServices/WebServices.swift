//
//  WebServices.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Alamofire

class WebServices {
    
    public private(set) var baseUrl = "https://mock-api-mobile.dev.lalamove.com"
    
}

extension WebServices {
    
    @objc func requestForGetType(url: String, parameters: [NSString: NSObject], _ responseBlock: @escaping ((_ response: Any?, _ error: Error?) -> Void)) {
        Alamofire.request(url, method: .get, parameters: parameters as Parameters).validate().responseJSON { (response) in
            responseBlock(response.result.value as Any, response.error)
        }
    }
    
}
