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

  var body: some Scene {
    WindowGroup {
      ContentView()
              .environment(\.managedObjectContext, dataController.container.viewContext)
    }
  }
}
