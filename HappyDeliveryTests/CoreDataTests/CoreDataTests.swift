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
        
        self.initStubs()
        
    }
    
    override func tearDown() {
        flushData()
    }
    
    func testDeliveryProductCount() {
        let deliveryProducts = self.fetchDeliveryList(offset: 0, limit: 5)
        XCTAssertEqual(deliveryProducts.count, 5)
    }
    
    func testDeliveryProductInsertion() {
        
        let mockDeliveryItem = self.createMockDeliveryList(id: 1)
        self.insertData(deliveryList: mockDeliveryItem)
        XCTAssertNotNil(mockDeliveryItem)
    }
    
    func testCheckDeliveryListItem() {
        
        XCTAssertNotNil(CoreDataHelper.shared.deliveryEntityExists(id: 0))
        
    }
    
    func testAddDeliveryList() {
        
        CoreDataHelper.shared.managedContext = mockPersistantContainer.viewContext
        
        let dictionary: NSDictionary = ["id": 0]
        
        CoreDataHelper.shared.save(deliveryList: [DeliveryListModel(dictionary: dictionary)!])
        
    }
    
    func initStubs() {
        
        let mockDeliveryItem1 = createMockDeliveryList(id: 1)
        self.insertData(deliveryList: mockDeliveryItem1)
        let mockDeliveryItem2 = createMockDeliveryList(id: 2)
        self.insertData(deliveryList: mockDeliveryItem2)
        let mockDeliveryItem3 = createMockDeliveryList(id: 3)
        self.insertData(deliveryList: mockDeliveryItem3)
        let mockDeliveryItem4 = createMockDeliveryList(id: 4)
        self.insertData(deliveryList: mockDeliveryItem4)
        let mockDeliveryItem5 = createMockDeliveryList(id: 5)
        self.insertData(deliveryList: mockDeliveryItem5)
        
    }
    
    func createMockDeliveryList(id: Int) -> DeliveryListModel {
        
        let locationDictionary: NSDictionary = ["lat": 28.459497, "lng": 77.026634, "address": "Gurgaon"]
        
        let deliveryListDictionary: NSDictionary = ["id": id, "description": "Deliver to John", "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-8.jpeg", "location": locationDictionary]
        
        let deliveryList = DeliveryListModel(dictionary: deliveryListDictionary)!
        
        return deliveryList
        
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

extension CoreDataTests {
    
    func insertData(deliveryList: DeliveryListModel) {
        
        let managedContext = self.mockPersistantContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName().deliveryList, in: managedContext)!
        
        let deliveryListObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        deliveryListObject.setValue(deliveryList.id, forKeyPath: DeliveryListEntityAttribute().id)
        deliveryListObject.setValue(deliveryList.description, forKeyPath: DeliveryListEntityAttribute().desc)
        deliveryListObject.setValue(deliveryList.imageUrl, forKeyPath: DeliveryListEntityAttribute().imageUrl)
        
        let locationEntity = NSEntityDescription.entity(forEntityName: CoreDataEntityName().location, in: managedContext)!
        
        let locationObject = NSManagedObject(entity: locationEntity, insertInto: managedContext)
        
        locationObject.setValue(deliveryList.location?.lat, forKeyPath: LocationEntityAttribute().lat)
        locationObject.setValue(deliveryList.location?.lng, forKeyPath: LocationEntityAttribute().lng)
        locationObject.setValue(deliveryList.location?.address, forKeyPath: LocationEntityAttribute().address)
        
        deliveryListObject.setValue(locationObject, forKeyPath: DeliveryListEntityAttribute().relationLocation)
        
        do {
            try managedContext.save()
            
        } catch _ as NSError {
            
        }
        
    }
    
    func fetchDeliveryList(offset: Int, limit: Int) -> [DeliveryListModel] {
        
        let managedContext = self.mockPersistantContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: CoreDataEntityName().deliveryList)
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        fetchRequest.resultType = .managedObjectResultType
        
        do {
            
            let deliveryListManagedObject = try managedContext.fetch(fetchRequest)
            
            let model = DeliveryListModel.arrayModelFromManagedObject(array: deliveryListManagedObject)
            
            return model
            
        } catch _ as NSError {
            
        }
        
        return []

    }
    
}
