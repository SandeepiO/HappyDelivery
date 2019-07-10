//
//  AppConstant.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

// MARK: ApiEndPoint
struct ApiEndPoint {
    let deliveries = "/deliveries"
}

struct TableViewCell {
    static let cell = "cell"
}

struct CoreDataEntityName {
    let deliveryList = "DeliveryList"
    let location = "Location"
}

struct DeliveryListEntityAttribute {
    let id = "id"
}

let kStartOffset = 0
let kListLimit = 20
let kLocationMeter = 1000
let kTableViewDefaultHeight = 100
let kZeroNumberOfLine = 0

struct Constraint {
    struct Constant {
        static let zero: CGFloat = 0
        static let ten: CGFloat = 10
        static let twenty: CGFloat = 20
        static let eight: CGFloat = 8
        static let sixty: CGFloat = 60
        static let minusTen: CGFloat = -10
        static let minusTwenty: CGFloat = -20
    }
    
    struct Multiplier {
        static let one: CGFloat = 1.0
    }
    
    struct Priority {
        static let medium: Float = 500
    }
}

struct Animation {
    struct Scale {
        static let x: CGFloat = 0.2
        static let y: CGFloat = 0.2
    }

    struct Duration {
        static let time = 0.4
    }
}

struct MapMarker {
    static let marker = "marker"
}

struct EdgeInsetsValue {
    static let top: CGFloat = -15
    static let bottom: CGFloat = 0
    static let left: CGFloat = 0
    static let right: CGFloat = 0
}
