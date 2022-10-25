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
      } else if let error = error {
        print(error.localizedDescription)
      }
    }
  }

  func sendNotification(date: Date, type: String, timeInterval: Double = 5, title: String, body: String) {
    var trigger: UNNotificationTrigger?

    if type == "date" {
      let dataComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
      trigger = UNCalendarNotificationTrigger(dateMatching: dataComponents, repeats: false)
    } else if type == "time" {
      trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    }

    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    UNUserNotificationCenter.current().add(request)
  }

  func resetPermission() {
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
  }

  func checkNotification() {
    UNUserNotificationCenter.current().getNotificationSettings { [self] settings in
      if settings.authorizationStatus == .authorized {
        UserDefaults.standard.set(true, forKey: "isNotificationEnabled")
      } else {
        UserDefaults.standard.set(false, forKey: "isNotificationEnabled")
      }
    }

  }

}
