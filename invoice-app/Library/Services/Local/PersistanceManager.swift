//
//  PersistanceManager.swift
//  invoice-app
//
//  Created by Bartłomiej Gaweł on 20/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import CoreData

class PersistanceManager {
    
    let persistentContainer = NSPersistentContainer(name: "CoreData")
    
    init() {
        self.initalizeStack()
    }
    
    func initalizeStack() {
        self.persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("could not load store \(error.localizedDescription)")
                return
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved")
                context.reset()
                
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror)")
            }
        }
    }
    
    // READ
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
            
            } catch {
                print(error)
                return [T]()
            }
        }
    }
