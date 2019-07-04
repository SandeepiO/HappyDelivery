//
//  CoreDataTests.swift
//  HappyDeliveryTests
//
//  Created by Sandeep Yadav on 01/07/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import XCTest
import CoreData
@testable import HappyDelivery

class CoreDataTests: XCTestCase {
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "HappyDelivery", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false // Make it simpler in test env
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            
            // Check if creating container wrong
            if let error = error {
                fatalError("Create an in-memory coordinator failed \(error)")
            }
        }
        return container
    }()
    
    override func setUp() {
        
    }
    
    override func tearDown() {
        flushData()
    }
    
    func testCheckDeliveryListItem() {
        
        XCTAssertNotNil(CoreDataHelper.shared.deliveryEntityExists(id: 0))
        
    }
    
    func testAddDeliveryList() {
        
        CoreDataHelper.shared.managedContext = mockPersistantContainer.viewContext
        
        let dictionary: NSDictionary = ["id": 0]
        
        CoreDataHelper.shared.save(deliveryList: [DeliveryListModel(dictionary: dictionary)!])
        
    }
    
    func flushData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName().deliveryList)
        let objs = try? mockPersistantContainer.viewContext.fetch(fetchRequest)
        if let objs = objs {
            for case let obj as NSManagedObject in objs {
                mockPersistantContainer.viewContext.delete(obj)
            }
            do {
                try mockPersistantContainer.viewContext.save()
            } catch {
                debugPrint("Save context fail \(error)")
            }
        }
        
    }
    
}
