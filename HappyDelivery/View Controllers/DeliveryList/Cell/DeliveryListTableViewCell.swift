//
//  DeliveryListTableViewCell.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 26/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import UIKit

class DeliveryListTableViewCell: UITableViewCell {

    var backView: UIView!
    
    var deliveryItemImageView: UIImageView!
    
    var descriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUpUI()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: DeliveryListModel) {
        
        if let url = URL(string: data.imageUrl ?? "") {
            self.deliveryItemImageView.sd_setImage(with: url, completed: nil)
        } else {
            self.deliveryItemImageView.image = UIImage()
        }
        
        self.descriptionLabel.text = (data.description ?? "") + StringValue.at + (data.location?.address ?? "")
        
    }
    
    func setUpUI() {
        
        self.backgroundColor = .clear
        
        backView = UIView()
        deliveryItemImageView = UIImageView()
        descriptionLabel = UILabel()
        
        self.descriptionLabel.numberOfLines = kNumberOfNumber
        self.backView.backgroundColor = .white
        
        backView.addSubview(deliveryItemImageView)
        backView.addSubview(descriptionLabel)
        contentView.addSubview(backView)
        
        backView?.translatesAutoresizingMaskIntoConstraints = false
        deliveryItemImageView?.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraintForDeliveryImageView()
        self.addConstraintForDescriptionLabel()
        self.addConstraintForBackView()
        self.backView.setBorderAndShadow()
        
    }
    
    func addConstraintForDeliveryImageView() {
        
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.top, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: Constraint.Constant.ten, constant: Constraint.Constant.sixty).isActive = true
        
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.sixty).isActive = true
        
        let bottomConstriant = NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: backView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen)
        
        bottomConstriant.priority = UILayoutPriority(rawValue: Constraint.Priority.medium)
        bottomConstriant.isActive = true
        
    }
    
    func addConstraintForDescriptionLabel() {
    
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: deliveryItemImageView, attribute: NSLayoutConstraint.Attribute.top, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: deliveryItemImageView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen).isActive = true
        
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTwenty).isActive = true
    
    }
    
    func addConstraintForBackView() {
        
        NSLayoutConstraint(item: backView as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: .leading, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        
        NSLayoutConstraint(item: backView as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: .top, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        
        NSLayoutConstraint(item: backView as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: .trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen).isActive = true
        
        NSLayoutConstraint(item: backView as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: .bottom, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen).isActive = true
        
    }
    
}
