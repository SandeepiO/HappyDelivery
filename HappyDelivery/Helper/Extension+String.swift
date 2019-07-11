//
//  Extension+String.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 11/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation

extension String {

    var localized: String {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }

}
