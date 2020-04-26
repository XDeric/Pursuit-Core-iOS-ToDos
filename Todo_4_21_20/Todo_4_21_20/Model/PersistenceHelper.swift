//
//  Persistence Helper.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/26/20.
//  Copyright © 2020 EricM. All rights reserved.
//

import UIKit
import CoreData

final class PersistanceHelper{
    
    private init (){}
    //Singleton
    static let shared = PersistanceHelper()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Todo_4_21_20")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    // MARK: - Core Data Saving support
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
//                print("saved")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /// Fetches data from ReciepeData
    func fetchData <T: NSManagedObject>(_ objectType: T.Type)-> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do{
            let data = try context.fetch(fetchRequest) as? [T]
            return data ?? [T]()
        } catch{
            print(error)
            return [T]()
        }
    }
    
    func update<T: NSManagedObject>(objectType: T.Type, identifier: String){
        moc.performAndWait {
            let entityName = String(describing: objectType)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            let predicate = NSPredicate(format: "title CONTAINS[c] %@", "\(identifier)")
            fetchRequest.predicate = predicate
            fetchRequest.fetchLimit = 1
            
            do {
                let records = try context.fetch(fetchRequest) as! [NSManagedObject]
                for record in records {
                    if record.isUpdated == true{
                        self.save()
                    }
                    else {
                    }
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    ///Targets specific ReciepeData from coreData then deletes it
    func delete<T: NSManagedObject>(objectType: T.Type, identifier: String){
        moc.performAndWait {
            //Goes to ReciepeData object
            let entityName = String(describing: objectType)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            
            //looks through ReciepeData at title
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            //filters through by the title
            let predicate = NSPredicate(format: "name CONTAINS[c] %@", "\(identifier)")
            fetchRequest.predicate = predicate
            fetchRequest.fetchLimit = 1
            
            //Deletes
            do {
                let records = try context.fetch(fetchRequest) as! [NSManagedObject]
                for record in records {
                    context.delete(record)
                    save()
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
}
