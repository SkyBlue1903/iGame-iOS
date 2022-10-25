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
  @StateObject var viewRouter = ViewRouter()

  var body: some Scene {
    WindowGroup {
      PageController()
              .environment(\.managedObjectContext, dataController.container.viewContext)
              .environmentObject(viewRouter)

    }

  }
}
