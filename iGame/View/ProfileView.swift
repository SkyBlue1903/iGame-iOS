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
  @State private var isShowingAlert = false
  @State var isNotificationEnabled = UserDefaults.standard.bool(forKey: "isNotificationEnabled")
  let notification = NotificationHandler()
  @State var isNotified = false

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
            isShowingAlert.toggle()
          }
                  .confirmationDialog("Are you sure?",
                          isPresented: $isShowingAlert) {
                    Button("Delete", role: .destructive) {
                      Profile.resetProfile()
                      viewRouter.currentPage = .welcome
                    }
                  } message: {
                    Text("This action cannot be undone, continue?")
                  }
        }

          Section(header: Text("Notification Settings")) {
            Toggle("Daily update", isOn: $isNotified)

          }
      }
              .onAppear {
                getProfile()
              }
              .navigationTitle("Hi, \(username)!👋")
              .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                // done button
                  Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                  }
                }
              }
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
