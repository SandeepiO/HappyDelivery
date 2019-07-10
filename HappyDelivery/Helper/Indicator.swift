//
//  Indicator.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation

public class Indicator {
    
    static let shared = Indicator()
    
    let container: UIView = UIView()
    let loadingView: UIView = UIView()
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    public func showActivityIndicatory(uiView: UIView) {
        DispatchQueue.main.async {[weak self] in
            self?.container.isHidden = false
            self?.loadingView.isHidden = false
            self?.actInd.isHidden = false
            self?.container.frame = uiView.frame
            self?.container.center = uiView.center
            self?.container.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self?.loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self?.loadingView.center = uiView.center
            self?.loadingView.backgroundColor = UIColor.white
            self?.loadingView.clipsToBounds = true
            self?.loadingView.layer.cornerRadius = 10
            self?.actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            self?.actInd.style =
                UIActivityIndicatorView.Style.gray
            self?.actInd.center = CGPoint(x: (self?.loadingView.frame.size.width ?? 0.0) / 2, y: (self?.loadingView.frame.size.height ?? 0.0) / 2)
            self?.loadingView.addSubview(self?.actInd ?? UIActivityIndicatorView())
            self?.container.addSubview(self?.loadingView ?? UIView())
            uiView.addSubview(self?.container ?? UIView())
            self?.actInd.startAnimating()
        }
    }
    
    public func hideAcivityIndicator() {
        container.isHidden = true
        loadingView.isHidden = true
        actInd.isHidden = true
        actInd.stopAnimating()
    }
    
}
