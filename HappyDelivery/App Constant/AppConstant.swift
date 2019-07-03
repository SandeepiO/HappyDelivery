//
//  AppConstant.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

struct ApiEndPoint {
    let deliveries = "/deliveries"
}

struct AlertTile {
    let appTitle = "Happy Delivery"
    let somethingWenWrong = "Something Went Wrong, Please try again!"
    let resultNotFetched = "No result Found, Please try agian!"
}

struct CoreDataEntityName {
    let deliveryList = "DeliveryList"
    let location = "Location"
}

struct DeliveryListEntityAttribute {
    let id = "id"
    let desc = "desc"
    let imageUrl = "imageUrl"
    
    let relationLocation = "location"
}

struct LocationEntityAttribute {
    let lat = "lat"
    let lng = "lng"
    let address = "address"
}

struct NavigationTitle {
    let deliveryList = "Things to deliver"
    let deliveryDetail = "Delivery Details"
}

let kListLimit = 20
let kLocationMeter = 1000
let kTableViewDefaultHeight = 100
