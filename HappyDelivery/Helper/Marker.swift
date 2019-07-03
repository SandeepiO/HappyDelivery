//
//  MapMarker.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 28/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import MapKit

class Marker: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        
        self.title = title
        self.coordinate = coordinate
        
        super.init()
        
    }
    
}
