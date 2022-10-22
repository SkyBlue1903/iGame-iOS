//
//  PageController.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/10/22.
//

import SwiftUI

struct PageController: View {

    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        switch viewRouter.currentPage {
        case .welcome:
            WelcomeView()
                .transition(.slide)
        case .home:
            ContentView()
                .transition(.slide)
        }
    }
}

struct PageController_Previews: PreviewProvider {
    static var previews: some View {
        PageController()
            .environmentObject(ViewRouter())
    }
}