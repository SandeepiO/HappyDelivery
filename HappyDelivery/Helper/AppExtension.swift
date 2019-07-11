//
//  AppExtension.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ message: String, _ completion: (() -> Void)?) {
        let alert = UIAlertController(title: AlertTile().appTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: AlertKey.ok, style: UIAlertAction.Style.default) { (action) in
            completion?()
        }
        alert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithCancelButton(_ message: String, _ okButtonTitle: String, _ completion: (() -> Void)?, _ alertShown: (() -> Void)?) {
        let alert = UIAlertController(title: AlertTile().appTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { (action) in
            completion?()
        }
        let cancelAction = UIAlertAction(title: AlertKey.cancel, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true) {
            alertShown?()
        }
    }
    
}

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

public extension String {

    var localized: String {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }

}
