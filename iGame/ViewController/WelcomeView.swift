//
//  WelcomeView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/10/22.
//

import SwiftUI

struct WelcomeView: View {

  @State var username = ""
  @State var fullname = ""
  @State var job = ""
//  @State var photo = ""
  @State var isButtonAppear = false
  @FocusState var isInputActive: Bool
  @EnvironmentObject var viewRouter: ViewRouter

  @ViewBuilder
  var body: some View {
    VStack {
      let _ = print("Current uname: \(username)")
      Image(uiImage: UIImage(named: "welcome")!)
              .resizable()
              .scaledToFit()
              .frame(height: 250)
              .padding(.bottom, 30)
              .padding(.horizontal, 25)
              .padding(.top, 50)
      Text("Welcome to iGame")
              .font(.title)
              .fontWeight(.heavy)

      Text("Your gaming companion app")
              .font(.title3)
              .fontWeight(.regular)
              .padding(.bottom, 30)

      Text("To continue, please fill your username")
              .font(.subheadline)
              .foregroundColor(.gray)


      TextField("Length min. 3 characters", text: $username, onEditingChanged: { _ in
        if (username.count >= 3) {
          isButtonAppear = true
        } else {
          isButtonAppear = false
        }
      })
              .frame(height: 40)
              .background(Color(.systemGray6))
              .cornerRadius(10)
              .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
              .focused($isInputActive)
              .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                  Spacer()
                  Button("Done") {
                    isInputActive = false
                  }
                }
              }
      if isButtonAppear {
//        Button(action: {
//          Profile.saveProfile(username: username, fullname: fullname, job: job)
//          ContentView()
//        }, label: {
//          VStack {
//            Text("Let's Go \(Image(systemName: "arrow.forward"))")
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 60)
//                    .padding(.horizontal, 100)
//                    .background(Color.blue)
//                    .cornerRadius(50)
//          }
//                  .padding(.horizontal, 50)
//                  .padding(.bottom, 25)
//                  .frame(maxHeight: .infinity, alignment: .bottom)
//        })
//                .padding(.top, 30)

        Button(action: {
          Profile.saveProfile(username: username, fullname: fullname, job: job)
          withAnimation {
            viewRouter.currentPage = .home
          }
        }) {
          goHomeButton()
        }
      }
    }
            .onAppear {
              getProfile()
              if username != "" {
                viewRouter.currentPage = .home
              }
            }
  }


  func getProfile() {
    username = UserDefaults.standard.string(forKey: "Username") ?? ""
    fullname = UserDefaults.standard.string(forKey: "Fullname") ?? ""
    job = UserDefaults.standard.string(forKey: "Job") ?? ""
  }
}

struct goHomeButton: View {
  var body: some View {
    VStack {
      Text("Let's Go \(Image(systemName: "arrow.forward"))")
              .font(.title3)
              .fontWeight(.bold)
              .foregroundColor(.white)
              .frame(maxWidth: .infinity)
              .frame(height: 60)
              .padding(.horizontal, 100)
              .background(Color.blue)
              .cornerRadius(50)
    }
            .padding(.horizontal, 50)
            .padding(.bottom, 25)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.top, 30)

  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView()
  }
}
