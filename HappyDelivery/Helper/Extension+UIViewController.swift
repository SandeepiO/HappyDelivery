//
//  Extension+UIViewController.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 11/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation

extension UIViewController {

    func showAlert(_ message: String, _ completion: (() -> Void)?) {
        let alert = UIAlertController(title: Localisation.AlertTile.appTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: Localisation.AlertKey.ok, style: UIAlertAction.Style.default) { (action) in
            completion?()
        }
        alert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func showAlertWithCancelButton(_ message: String, _ okButtonTitle: String, _ completion: (() -> Void)?, _ alertShown: (() -> Void)?) {
        let alert = UIAlertController(title: Localisation.AlertTile.appTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { (action) in
            completion?()
        }
        let cancelAction = UIAlertAction(title: Localisation.AlertKey.cancel, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true) {
            alertShown?()
        }
    }

}
