//
//  NotificationHandler.swift
//  iGame
//
// Created by Erlangga Anugrah Arifin on 24/10/22.
//

import SwiftUI
import UserNotifications

class NotificationHandler {


  func askPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
      if success {
        UserDefaults.standard.set(true, forKey: "isNotificationEnabled")
        print("Notification enabled")
      } else if let error = error {
        print(error.localizedDescription)
      } else if !success {
        UserDefaults.standard.set(false, forKey: "isNotificationEnabled")
      }
    }
  }

  func sendNotification(daily: Bool) {

    var date = DateComponents()
    date.hour = 6
    date.minute = 00

    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: daily)

    let content = UNMutableNotificationContent()
    let getToday = Date.today
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    let today = formatter.string(from: getToday)

    content.title = "Daily game updates"
    content.body = "\(today) picks for \(userFullName()), let's explore!"
    content.sound = UNNotificationSound.default

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request)
  }

  func RemoveAllSentNotifications() {
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
  }

  func checkPermission() {
    UNUserNotificationCenter.current().getNotificationSettings { settings in
      if settings.authorizationStatus == .authorized {
        UserDefaults.standard.set(true, forKey: "isNotificationEnabled")
      } else {
        UserDefaults.standard.set(false, forKey: "isNotificationEnabled")
      }
    }

  }

  func testNotification() {
    UNUserNotificationCenter.current().getNotificationSettings { [self] settings in
      if settings.authorizationStatus == .authorized {
        print("Notification will be sent in 5 secs")
        let content = UNMutableNotificationContent()
        _ = Date.today
        content.title = "iGame notification"
        content.body = "Hey \(userFullName()), don't forget we'll sent you game updates daily at 6 am"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)


        UNUserNotificationCenter.current().add(request)
      }
    }
  }

  func userFullName() -> String {
    if UserDefaults.standard.string(forKey: "Fullname")!.count == 0 {
      return "You"
    } else {
      return UserDefaults.standard.string(forKey: "Fullname")!
    }

  }

}
