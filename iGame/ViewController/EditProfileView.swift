//
//  EditProfileView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 21/10/22.
//

import SwiftUI

struct EditProfileView: View {

  @State var name = ""
  @State var job = ""
  @State var photo = ""

  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("User detail")) {
            TextField("Your nickname", text: $name)
            TextField("Your current job", text: $job)
          }
          Section {
//            Button("Save") {
//              Profile.saveProfile(name: name, job: job)
//            }
          }
        }
                .onAppear {
                  Profile.getProfile()
                }
      }
              .navigationTitle("Edit Profile")
    }
  }
}

struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
    EditProfileView()
  }
}
