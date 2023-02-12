//
//  NotificationManager.swift
//  ToDoList
//
//  Created by Halil Bakar on 19.02.2023.
//

import Foundation
import UserNotifications

struct NotificationManager {
    
    static func localNotification(_ task: String, _ note: String, _ date: Date) {
        
        let notificationContent = UNMutableNotificationContent()
        
        if task == "" || note == "" {
            notificationContent.title = "Take action for the task you saved."
            notificationContent.subtitle = ""
            
        } else {
            notificationContent.title = task
            notificationContent.subtitle = note
        }
        
        notificationContent.sound = UNNotificationSound.default
        
        let triggerTime = Calendar.current.dateComponents( [.year ,.month ,.day ,.hour, .minute],
                                                           from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: false)
        
        let request = UNNotificationRequest(identifier: "ToDoList",
                                            content: notificationContent,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
