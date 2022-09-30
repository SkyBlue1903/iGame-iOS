//
// Created by Erlangga Anugrah Arifin on 28/09/22.
//

import SwiftUI

struct WebsiteButtonView: View {

    var game: Game

    var body: some View {
        GroupBox() {
            HStack {
                Image(systemName: "globe")
                Text("Website")
                Spacer()
                Link("\(game.developers[0])'s website", destination: URL(string: "\(game.website)")!)
                Image(systemName: "arrow.up.right")
            }
                    .font(.footnote)
        }
    }
}
