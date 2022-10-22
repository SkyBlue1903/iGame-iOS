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
//  @State var photo = ""
  @State var isShowingDevPage = false
  @State private var isShowingAlert = false

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
        }
        Section(header: Text("Developer Information")) {
          Button("Show Developer Page") {
            isShowingDevPage.toggle()
          }
                  .sheet(isPresented: $isShowingDevPage) {
                    DeveloperProfileView()
                  }
        }
        Section(header: Text("Reset")) {
          Button("Delete Profile", role: .destructive) {
            isShowingAlert.toggle()
          }
                  .confirmationDialog("Are you sure?",
                          isPresented: $isShowingAlert) {
                    Button("Delete", role: .destructive) {
                      Profile.resetProfile()
                      WelcomeView()
                    }
                  } message: {
                    Text("This action cannot be undone, continue?")
                  }
        }
      }
              .onAppear {
                getProfile()
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
