//
//  DeliveryDetailViewController.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 28/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {

    let mapView: MKMapView! = MKMapView()
    var bottomView: UIView! = UIView()
    var deliveryItemImageView: UIImageView! = UIImageView()
    var descriptionLabel: UILabel! = UILabel()
    var deliveryListData: DeliveryListModel?
    
    init(model: DeliveryListModel) {
        super.init(nibName: nil, bundle: nil)
        self.deliveryListData = model
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        self.title = Localisation.NavigationTitle.deliveryDetail
        self.view.backgroundColor = .white
        self.descriptionLabel.numberOfLines = kZeroNumberOfLine
        self.bottomView.backgroundColor = .white
        self.view.addSubview(mapView)
        self.bottomView.addSubview(deliveryItemImageView)
        self.bottomView.addSubview(descriptionLabel)
        self.view.addSubview(bottomView)
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.deliveryItemImageView.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraintForMapView()
        self.addConstraintForDeliveryItemImageView()
        self.addConstraintFordescriptionLabel()
        self.addConstraintForBottomView()
        self.bottomView.setBorderAndShadow()
        self.mapView.delegate = self
        self.setData()
    }
    
    func addConstraintForMapView() {
        NSLayoutConstraint(item: mapView as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        NSLayoutConstraint(item: mapView as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        NSLayoutConstraint(item: mapView as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        NSLayoutConstraint(item: mapView as Any, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .height, multiplier: Constraint.Multiplier.one, constant: self.view.bounds.height/2).isActive = true
        
    }
    
    func addConstraintForDeliveryItemImageView() {
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bottomView, attribute: NSLayoutConstraint.Attribute.top, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bottomView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.sixty).isActive = true
        NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.sixty).isActive = true
        let bottomConstriant = NSLayoutConstraint(item: deliveryItemImageView as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.lessThanOrEqual, toItem: bottomView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen)
        bottomConstriant.priority = UILayoutPriority(rawValue: Constraint.Priority.medium)
        bottomConstriant.isActive = true
    }
    
    func addConstraintFordescriptionLabel() {
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: deliveryItemImageView, attribute: NSLayoutConstraint.Attribute.top, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.zero).isActive = true
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: deliveryItemImageView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bottomView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen).isActive = true
        NSLayoutConstraint(item: descriptionLabel as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: bottomView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTwenty).isActive = true
    }
    
    func addConstraintForBottomView() {
        NSLayoutConstraint(item: bottomView as Any, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: .leading, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        NSLayoutConstraint(item: bottomView as Any, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mapView, attribute: .bottom, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.ten).isActive = true
        NSLayoutConstraint(item: bottomView as Any, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: .trailing, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen).isActive = true
        NSLayoutConstraint(item: bottomView as Any, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: .bottomMargin, multiplier: Constraint.Multiplier.one, constant: Constraint.Constant.minusTen).isActive = true
    }
    
    func setData() {
        if let url = URL(string: deliveryListData?.imageUrl ?? "") {
            self.deliveryItemImageView.sd_setImage(with: url, completed: nil)
        } else {
            self.deliveryItemImageView.image = UIImage()
        }
        self.descriptionLabel.text = (deliveryListData?.description ?? "") + Localisation.StringValue.at + (deliveryListData?.location?.address ?? "")
        let marker = Marker(title: deliveryListData?.location?.address ?? "", coordinate: CLLocationCoordinate2D(latitude: deliveryListData?.location?.lat ?? 0.0, longitude: deliveryListData?.location?.lng ?? 0.0))
        self.mapView.addAnnotation(marker)
        self.centerMapOnLocation(location: marker.coordinate)
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(kLocationMeter), longitudinalMeters: CLLocationDistance(kLocationMeter))
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
}

// MARK: - Map View Delegate
extension DeliveryDetailViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Marker else { return nil }
        let identifier = MapMarker.marker
        if #available(iOS 11.0, *) {
            var view: MKMarkerAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: 0, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .roundedRect)
            }
            return view
        } else {
            let reuseIdentifier = MapMarker.marker
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
    }
}
