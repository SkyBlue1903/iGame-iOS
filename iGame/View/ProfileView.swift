//
//  ProfileView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/10/22.
//

import SwiftUI

struct ProfileView: View {

  @State var username = ""
  @State var fullname = ""
  @State var job = ""

  @State var isShowingDevPage = false
  @State var isShowingEditPage = false
  @State private var isShowingDeleteAlert = false
  @State private var isShowingNotificationAlert = false
  @State var currentSetting = UserDefaults.standard.bool(forKey: "isNotificationEnabled")
  @State var dailyToggle = UserDefaults.standard.bool(forKey: "DailyNotifications")
  let notification = NotificationHandler()

  @EnvironmentObject var viewRouter: ViewRouter
  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("User detail")) {
          Text(username)
          if fullname == "" {
            Text("Your fullname")
                    .foregroundColor(.gray)
          } else {
            Text(fullname)
          }
          if job == "" {
            Text("Your current job")
                    .foregroundColor(.gray)
          } else {
            Text(job)
          }
          Button(action: {
            isShowingEditPage.toggle()
          }) {
            Text("Edit Profile")
          }
                  .sheet(isPresented: $isShowingEditPage, onDismiss: {
                    getProfile()
                  }) {
                    EditProfileView()
                  }
        }
        Section(header: Text("Developer Information")) {
          Button("Show Developer Page") {
            isShowingDevPage.toggle()
          }
                  .sheet(isPresented: $isShowingDevPage) {
                    DeveloperProfileView()
                  }
        }
        Section(header: Text("Reset Profile")) {
          Button("Delete Profile", role: .destructive) {
            isShowingDeleteAlert.toggle()
          }
                  .confirmationDialog("Are you sure?",
                          isPresented: $isShowingDeleteAlert) {
                    Button("Delete", role: .destructive) {
                      Profile.resetProfile()
                      viewRouter.currentPage = .welcome
                    }
                  } message: {
                    Text("This action cannot be undone, continue?")
                  }
        }

        Section(header: Text("Notification Settings"), footer: Text("We'll sent daily updates at 6 am.\nA test notification will be sent in 5 seconds.")) {
          Toggle("Daily Update", isOn: $dailyToggle)
                  .alert(isPresented: $isShowingNotificationAlert) {
                    Alert(title: Text("Notification Permission"),
                            message: Text("Please enable notification permission in the settings, or try restarting the app."),
                            dismissButton: .default(Text("OK")))
                  }
                  .onChange(of: dailyToggle) { _ in
                    if dailyToggle {
                      if !currentSetting {
                        dailyToggle.toggle()
                        isShowingNotificationAlert.toggle()
                      } else {
                        UserDefaults.standard.set(true, forKey: "DailyNotifications")
                        notification.sendNotification(daily: true)
                      }
                    } else {
                      UserDefaults.standard.set(false, forKey: "DailyNotifications")
                      notification.sendNotification(daily: false)
                      notification.RemoveAllSentNotifications()
                    }
                  }

          Button("Test Notification") {
            notification.testNotification()
          }
                  .disabled(!dailyToggle)
        }
      }
              .onAppear {
                getProfile()
                let _ = print("Check notification: \(currentSetting)")
                notification.checkPermission()

              }
              .navigationTitle("Hi, \(username)!👋")
    }


  }


  func getProfile() {
    username = UserDefaults.standard.string(forKey: "Username") ?? ""
    fullname = UserDefaults.standard.string(forKey: "Fullname") ?? ""
    job = UserDefaults.standard.string(forKey: "Job") ?? ""
  }

  static func saveProfile(username: String, fullname: String, job: String) {
    UserDefaults.standard.set(username, forKey: "Username")
    UserDefaults.standard.set(fullname, forKey: "Fullname")
    UserDefaults.standard.set(job, forKey: "Job")
  }

}


struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

