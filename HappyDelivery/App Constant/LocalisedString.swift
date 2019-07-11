//
//  LocalisedString.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 08/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

struct Localisation {

    struct AlertTile {
        static let appTitle = "Happy Delivery".localized
        static let somethingWenWrong = "Something Went Wrong, Please try again!".localized
        static let resultNotFetched = "No result Found, Please try agian!".localized
    }

    struct NavigationTitle {
        static let deliveryList = "Things to deliver".localized
        static let deliveryDetail = "Delivery Details".localized
    }

    struct AlertKey {
        static let retry = "Retry".localized
        static let ok = "Ok".localized
        static let cancel = "Cancel".localized
    }

    struct StringValue {
        static let at = " at ".localized
        static let noResultData = "No Data found.\n Please try pull to refresh".localized
    }

}
