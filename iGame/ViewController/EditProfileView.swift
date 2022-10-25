//
//  EditProfileView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 21/10/22.
//

import SwiftUI
import Combine

struct EditProfileView: View {

  @State var username = ""
  @State var fullname = ""
  @State var job = ""
  @State private var isShowingAlert = false

  @Environment(\.presentationMode) var presentationMode

  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("User detail"), footer: Text("Your username will be used to identify you in the app, max. 10 characters")) {
            TextField("Your username", text: $username)
                    .onReceive(Just(username)) { _ in limitText(10) }
            TextField("Your fullname", text: $fullname)
            TextField("Your current job", text: $job)
          }
          Section {
            Button("Save") {
              Profile.saveProfile(username: username, fullname: fullname, job: job)
              presentationMode.wrappedValue.dismiss()
            }
          }
        }
                .onAppear {
                  getProfile()
                }
      }
              .navigationTitle("Edit Profile")
              .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                  Button("Cancel", role: .destructive) {
                    isShowingAlert.toggle()
                  }
                          .confirmationDialog("Are you sure?",
                                  isPresented: $isShowingAlert) {
                            Button("Discard changes", role: .destructive) {
                              presentationMode.wrappedValue.dismiss()

                            }
                          } message: {
                            Text("Your current changes will be discarded, continue?")
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

  func limitText(_ upper: Int) {
    if username.count > upper {
      username = String(username.prefix(upper))
    }
  }

}

struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
    EditProfileView()
  }
}
