//
//  iGameApp.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI

@main
struct iGameApp: App {

  @StateObject private var dataController = DataController()
  @State var username = UserDefaults.standard.string(forKey: "Username")

  var body: some Scene {
    WindowGroup {
      if username == nil || username == "" {
        WelcomeView()
      } else {
        ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
      }
    }
  }
}
