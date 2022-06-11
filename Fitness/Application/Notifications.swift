//
//  Notifications.swift
//  Fitness
//
//  Created by Nataliya Lazouskaya on 4.06.22.
//

import Foundation
import UserNotifications
import UIKit

class Notifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings () {
        notificationCenter.getNotificationSettings { settings in
            print(settings)
        }
    }
    
    func scheduleDateNotofication(date: Date, id: String) {
        //создаем content
        let content = UNMutableNotificationContent()//mutable потому что будет менять его
        content.title = "WORKOUT"
        content.body = "Don't forget to train today"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        //создаем расписание
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        var triggerDate = calendar.dateComponents([.year, .month, .day], from: date)
        triggerDate.hour = 14
        triggerDate.minute = 58
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        //создаем trigger
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            print("Error \(error?.localizedDescription ?? "error")")
        }
    }
}

extension Notifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    //при нажатии на уведомление
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0 //когда уведомление, badge увеличится на 1
        notificationCenter.removeAllDeliveredNotifications()
    }
}
