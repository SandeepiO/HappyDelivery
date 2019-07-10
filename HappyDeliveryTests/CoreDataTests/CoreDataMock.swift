//
//  CoreDataMock.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 04/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import Foundation
import CoreData

class CoreDataMock {
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "HappyDelivery", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            if let error = error {
                fatalError("Create an in-memory coordinator failed \(error)")
            }
        }
        return container
    }()
    
}
