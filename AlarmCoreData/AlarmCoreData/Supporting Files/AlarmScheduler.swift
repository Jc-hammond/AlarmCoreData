//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Connor Hammond on 5/1/21.
//

import UserNotifications

protocol AlarmScheduler: AnyObject {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}




extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
        guard let timeOfDay = alarm.fireDate,
              let identifier = alarm.uuidString?.uuidString else {return}
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "\(alarm.title ?? Strings.alarm)"
        content.sound = UNNotificationSound.default
        
        let fireDateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeOfDay)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request\nError in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        guard let identifier = alarm.uuidString?.uuidString else {return}
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
