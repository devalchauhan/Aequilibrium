//
//  TransformerCoreData.swift
//  Transformers
//
//  Created by Deval on 16/02/19.
//  Copyright © 2019 Deval. All rights reserved.
//

import Foundation
import UIKit
import CoreData

let kEntityName = "Transformers"

class TransformerCoreData {
    
    static var applicationDocumentsDirectory: URL = {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    static var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle(for: TransformerCoreData.self).url(forResource: "Transformers", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    static var persistentStoreCoordinator: NSPersistentStoreCoordinator = {        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent("Transformers.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        let options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber(value: true as Bool), NSInferMappingModelAutomaticallyOption: NSNumber(value: true as Bool)]
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            
            dict[NSUnderlyingErrorKey] = error as NSError
            abort()
        }
        
        return coordinator
    }()
    
    static var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving Transformer
    static func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                abort()
            }
        }
    }
    
    static func saveTransformerToCoredata(transformer:Transformer) {
        
            let entityDesc = NSEntityDescription.entity(forEntityName: kEntityName, in: TransformerCoreData.managedObjectContext)
            let task = Transformers(entity: entityDesc!, insertInto: TransformerCoreData.managedObjectContext)
            task.id = transformer.id
            task.name = transformer.name
            task.team = transformer.team
            task.strength = Int64(transformer.strength)
            task.intelligence = Int64(transformer.intelligence)
            task.speed = Int64(transformer.speed)
            task.endurance = Int64(transformer.endurance)
            task.rank = Int64(transformer.rank)
            task.courage = Int64(transformer.courage)
            task.firepower = Int64(transformer.firepower)
            task.skill = Int64(transformer.skill)
            task.team_icon = transformer.team_icon
            TransformerCoreData.saveContext()
        
    }
    
    static func fetchTransformersFromCoreData() -> [Transformer] {
        let context = TransformerCoreData.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: kEntityName)
        request.returnsObjectsAsFaults = false
        var transformers : [Transformer] = []
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                let transformer = Transformer()
                transformer.id = data.value(forKey: "id") as? String
                transformer.name = data.value(forKey: "name") as? String
                transformer.team = data.value(forKey: "team") as? String
                transformer.strength = data.value(forKey: "strength") as! Int
                transformer.intelligence = data.value(forKey: "intelligence") as! Int
                transformer.speed = data.value(forKey: "speed") as! Int
                transformer.endurance = data.value(forKey: "endurance") as! Int
                transformer.rank = data.value(forKey: "rank") as! Int
                transformer.courage = data.value(forKey: "courage") as! Int
                transformer.firepower = data.value(forKey: "firepower") as! Int
                transformer.skill = data.value(forKey: "skill") as! Int
                transformer.team_icon = data.value(forKey: "team_icon") as? String
                transformers.append(transformer)
            }
        } catch {
            
        }
        return transformers
    }
    
    static func updateTransformerFromCoreData(transformer:Transformer) {
        let context = TransformerCoreData.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: kEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            request.predicate = NSPredicate.init(format: "id == \(String(describing: transformer.id!))")
            for data in result as! [NSManagedObject] {
                let transformer = Transformer()
                transformer.id = data.value(forKey: "id") as? String
                transformer.name = data.value(forKey: "name") as? String
                transformer.team = data.value(forKey: "team") as? String
                transformer.strength = data.value(forKey: "strength") as! Int
                transformer.intelligence = data.value(forKey: "intelligence") as! Int
                transformer.speed = data.value(forKey: "speed") as! Int
                transformer.endurance = data.value(forKey: "endurance") as! Int
                transformer.rank = data.value(forKey: "rank") as! Int
                transformer.courage = data.value(forKey: "courage") as! Int
                transformer.firepower = data.value(forKey: "firepower") as! Int
                transformer.skill = data.value(forKey: "skill") as! Int
                transformer.team_icon = data.value(forKey: "team_icon") as? String
                TransformerCoreData.saveContext()
            }
        } catch {
            
        }
        
        /*
        let context = TransformerCoreData.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: kEntityName, in: context)
        let batchUpdateRequest = NSBatchUpdateRequest(entity: entity!)
        batchUpdateRequest.predicate = NSPredicate.init(format: "id == \(String(describing: transformer.id))")
        batchUpdateRequest.resultType = NSBatchUpdateRequestResultType.updatedObjectIDsResultType
        batchUpdateRequest.propertiesToUpdate = ["id":transformer.id!,"name":transformer.name!,"team":transformer.team!,"strength":transformer.strength,"intelligence":transformer.intelligence,"speed":transformer.speed,"endurance":transformer.endurance,"rank":transformer.rank,"courage":transformer.courage,"firepower":transformer.firepower,"skill":transformer.skill,"team_icon":transformer.team_icon!]
        do {
            try context.execute(batchUpdateRequest)
        }
        catch {
            
        } */
    }
    
    static func removeTransformerFromCoreData(transformer:Transformer) {
        let context = TransformerCoreData.managedObjectContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: kEntityName)
        fetch.predicate = NSPredicate.init(format: "id==\(String(describing: transformer.id))")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try context.execute(request)
        }
        catch {
        
        }
    }
    
}
