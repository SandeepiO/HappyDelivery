//
//  Extension+UIView.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 11/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation

extension UIView {

    func setBorderAndShadow() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 6
        self.layer.shadowColor = UIColor.gray.cgColor
    }

}
