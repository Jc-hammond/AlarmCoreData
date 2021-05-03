//
//  Alarm+Convienience.swift
//  AlarmCoreData
//
//  Created by Connor Hammond on 4/29/21.
//

import CoreData

extension Alarm {
    
    @discardableResult convenience init(title: String, isEnabled: Bool, fireDate: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.uuidString = UUID()
        self.title = title
        self.isEnabled = isEnabled
        self.fireDate = fireDate
        
    }
    
    
    
}//End of extension
