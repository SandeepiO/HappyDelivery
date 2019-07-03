//
//  DeliveryListModel.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation
import CoreData

public class DeliveryListModel {
    
    public var id: Int?
    public var description: String?
    public var imageUrl: String?
    public var location: LocationModel?
    
    init?(dictionary: NSDictionary) {
        
        id = dictionary["id"]as? Int
        description = dictionary["description"]as? String ?? dictionary["desc"]as? String
        imageUrl = dictionary["imageUrl"]as? String
        
        if let locationDictionary = dictionary["location"]as? NSDictionary {
            location = LocationModel(dictionary: locationDictionary)
        }
        
    }
    
    public class func arrayModelFromDictionary(array: NSArray) -> [DeliveryListModel] {
        
        var deliveryListModel: [DeliveryListModel] = []
        
        for data in array {
            
            if let dataModel = data as? NSDictionary {
                
                let model = DeliveryListModel(dictionary: dataModel)!
                
                deliveryListModel.append(model)
                
            }
            
        }
        
        return deliveryListModel
        
    }
    
    // MARK: - For Core Data
    
    init?(data: NSManagedObject) {
        
        id = (data as? DeliveryList)?.value(forKeyPath: "id")as? Int
        description = (data as? DeliveryList)?.value(forKeyPath: "desc")as? String
        imageUrl = (data as? DeliveryList)?.value(forKeyPath: "imageUrl")as? String
        
        if let locationObject = (data as? DeliveryList)?.value(forKeyPath: "location")as? Location {
            
            location = LocationModel(data: locationObject)
            
        }
        
    }
    
    public class func arrayModelFromManagedObject(array: [NSManagedObject]) -> [DeliveryListModel] {
        
        var deliveryListModel: [DeliveryListModel] = []
        
        for data in array {
            
            let model = DeliveryListModel(data: data)!
            
            deliveryListModel.append(model)
            
        }
        
        return deliveryListModel
        
    }
    
}

public class LocationModel {
    
    public var lat: Double?
    public var lng: Double?
    public var address: String?
    
    init?(dictionary: NSDictionary) {
        
        lat = dictionary["lat"]as? Double
        lng = dictionary["lng"]as? Double
        address = dictionary["address"]as? String
        
    }
    
    // MARK: - For Core Data
    
    init?(data: NSManagedObject) {
        
        lat = (data as? Location)?.lat
        lng = (data as? Location)?.lng
        address = (data as? Location)?.address
        
    }
    
}
