//
//  CoreDataStack.swift
//  AlarmCoreData
//
//  Created by Connor Hammond on 4/29/21.
//

import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "AlarmCoreData")
        
        container.loadPersistentStores { (storeDescription, error) in
            
            if let error = error {
                fatalError("Error loading persistent stores \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { container.viewContext }

}//End of enum