//
//  WebServices.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Alamofire

class WebServices {
    
    static let shared = WebServices()
    
    public private(set) var baseUrl = "https://mock-api-mobile.dev.lalamove.com"
    
}

extension WebServices {
    
    func requestForGetType(url: String, parameters: [NSString: NSObject], _ successBlock: @escaping ((_ response: Any) -> Void), _ errorBlock: @escaping ((_ error: Error) -> Void)) {
        
        Alamofire.request(url, method: .get, parameters: parameters as Parameters).validate(statusCode: 200..<300).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                successBlock(response.result.value as Any)
                
            } else {
                
                errorBlock(response.error!)
                
            }
            
        }
        
    }
    
}
