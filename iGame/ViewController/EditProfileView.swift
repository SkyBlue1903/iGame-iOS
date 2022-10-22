//
//  EditProfileView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 21/10/22.
//

import SwiftUI
import AlertToast

struct EditProfileView: View {

  @State var username = ""
  @State var fullname = ""
  @State var job = ""
  @State private var showToast = false
//  @State var photo = ""

  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("User detail")) {
            TextField("Your nickname", text: $username)
            TextField("Your fullname", text: $fullname)
            TextField("Your current job", text: $job)
          }
          Section {
            Button("Save") {
              Profile.saveProfile(username: username, fullname: fullname, job: job)
              presentationMode.wrappedValue.dismiss()
              showToast = true
            }
          }
        }
                .onAppear {
                  getProfile()
                }
      }
              .toast(isPresenting: $showToast, duration: 5) {
                AlertToast(displayMode: .banner(.pop), type: .regular, title: "Profile edited", subTitle: "Re-open this sheet to see changes")
              }
              .navigationTitle("Edit Profile")
              .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                  Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                  }
                }
              }
              .onAppear {
                Profile.getProfile()
              }
    }
  }

  func getProfile() {
    username = UserDefaults.standard.string(forKey: "Username") ?? ""
    fullname = UserDefaults.standard.string(forKey: "Fullname") ?? ""
    job = UserDefaults.standard.string(forKey: "Job") ?? ""
  }

}

struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
    EditProfileView()
  }
}
