//
//  LocalisedString.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 08/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

struct AlertTile {
    let appTitle = "Happy Delivery".localized
    let somethingWenWrong = "Something Went Wrong, Please try again!".localized
    let resultNotFetched = "No result Found, Please try agian!".localized
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
    static let noResultData = "No Data found.\n Please try pull to refresh".localized
}
