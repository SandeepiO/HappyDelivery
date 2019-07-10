//
//  CoreDataHelper.swift
//  HappyDelivery
//
//  Created by Sandeep Yadav on 27/06/19.
//  Copyright © 2019 Sandeep Yadav. All rights reserved.
//

import CoreData

class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    
    var managedContext: NSManagedObjectContext = {
        let appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK: Save detail
    func save(deliveryList: [DeliveryListModel]) {
        for deliveryObject in deliveryList {
            if !self.deliveryEntityExists(id: deliveryObject.id ?? 0) {
                let entity = NSEntityDescription.entity(forEntityName: CoreDataEntityName().deliveryList, in: managedContext)!
                let deliveryListObject = NSManagedObject(entity: entity, insertInto: managedContext)as? DeliveryList
                deliveryListObject?.id = Int16(deliveryObject.id ?? 0)
                deliveryListObject?.desc = deliveryObject.description ?? ""
                deliveryListObject?.imageUrl = deliveryObject.imageUrl ?? ""
                let locationEntity = NSEntityDescription.entity(forEntityName: CoreDataEntityName().location, in: managedContext)!
                let locationObject = NSManagedObject(entity: locationEntity, insertInto: managedContext)as? Location
                locationObject?.lat = deliveryObject.location?.lat ?? 0.0
                locationObject?.lng = deliveryObject.location?.lng ?? 0.0
                locationObject?.address = deliveryObject.location?.address ?? ""
                deliveryListObject?.location = locationObject
                do {
                    try managedContext.save()
                } catch _ as NSError {
                }
            }
        }
    }
    
    // MARK: Check Detail is present or not
    func deliveryEntityExists(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreDataEntityName().deliveryList)
        fetchRequest.predicate = NSPredicate(format: "\(DeliveryListEntityAttribute().id) == %d", id)
        var results: [NSManagedObject] = []
        do {
            results = try managedContext.fetch(fetchRequest)
        } catch {
        }
        return results.count > 0
    }
    
    // MARK: Fetch the detail
    func getDeliveryListData(offset: Int, limit: Int) -> [DeliveryListModel] {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: CoreDataEntityName().deliveryList)
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = limit
        do {
            let deliveryListManagedObject = try managedContext.fetch(fetchRequest)
            let model = ModelConversion.arrayModelFromManagedObject(array: deliveryListManagedObject)
            return model
        } catch _ as NSError {
        }
        return []
    }
    
    // MARK: Delete all the detail
    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataEntityName().deliveryList)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
        }
    }
    
}
