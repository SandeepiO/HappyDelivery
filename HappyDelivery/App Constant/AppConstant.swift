//
//  AppConstant.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

struct ApiEndPoint {
    let deliveries = "/deliveries"
}

struct AlertTile {
    let appTitle = "Happy Delivery".localized
    let somethingWenWrong = "Something Went Wrong, Please try again!".localized
    let resultNotFetched = "No result Found, Please try agian!".localized
}

struct CoreDataEntityName {
    let deliveryList = "DeliveryList"
    let location = "Location"
}

struct DeliveryListEntityAttribute {
    let id = "id"
    let desc = "desc"
    let imageUrl = "imageUrl"
    
    let relationLocation = "location"
}

struct LocationEntityAttribute {
    let lat = "lat"
    let lng = "lng"
    let address = "address"
}

struct NavigationTitle {
    let deliveryList = "Things to deliver".localized
    let deliveryDetail = "Delivery Details".localized
}

struct AlertKey {
    static let retry = "Retry".localized
    static let ok = "Ok".localized
    static let cancel = "Cancel".localized
}

struct StringValue {
    static let at = " at "
}

let kListLimit = 20
let kLocationMeter = 1000
let kTableViewDefaultHeight = 100
let kNumberOfNumber = 0

struct Constraint {
    
    struct Constant {
        
        static let zero: CGFloat = 0
        static let ten: CGFloat = 10
        static let twenty: CGFloat = 20
        static let eight: CGFloat = 8
        static let sixty: CGFloat = 60
        static let minusTen: CGFloat = -10
        static let minusTwenty: CGFloat = -20
        
    }
    
    struct Multiplier {
        static let one: CGFloat = 1.0
    }
    
    struct Priority {
        static let medium: Float = 500
    }
}
