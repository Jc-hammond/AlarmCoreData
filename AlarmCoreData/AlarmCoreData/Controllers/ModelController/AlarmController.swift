//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Connor Hammond on 4/29/21.
//

import Foundation
import CoreData

class AlarmController: AlarmScheduler {
    
    
    //MARK: - Properties
    static var sharedInstance = AlarmController()
    var alarms: [Alarm] {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
    }
    
    
//    private lazy var fetchRequest: NSFetchRequest<Alarm> = {
//    let request = NSFetchRequest<Alarm>(entityName: "Alarm")
//       request.predicate = NSPredicate(value: true)
//        return request
//    }()

    
    private init() {}
    
    //MARK: - Functions
    func createAlarm(withTitle title: String, and fireDate: Date, isAlarmOn: Bool){
      let alarm = Alarm(title: title, isEnabled: isAlarmOn, fireDate: fireDate)
        if isAlarmOn {
            scheduleUserNotifications(for: alarm)
        }
        
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, newTitle: String, newFireDate: Date, isAlarmOn: Bool){
        
        cancelUserNotifications(for: alarm)
        
        alarm.title = newTitle
        alarm.fireDate = newFireDate
        alarm.isEnabled = isAlarmOn
        
        if isAlarmOn {
            scheduleUserNotifications(for: alarm)
        }
        
        saveToPersistentStore()
    }
    
    func toggleIsEnabledFor(alarm: Alarm){
        alarm.isEnabled.toggle()
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm){
        cancelUserNotifications(for: alarm)
        CoreDataStack.context.delete(alarm)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore(){
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }

        
        
}//End of class

