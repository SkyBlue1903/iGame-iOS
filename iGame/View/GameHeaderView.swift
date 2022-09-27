//
//  GameHeaderView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI

struct GameHeaderView: View {
    var image: String
    var game: Game
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: game.background_image)!, content: { image in
                image.resizable()
                        .scaledToFill()
                        .frame(height: 430)

            }, placeholder: {
                ProgressView()
                        .frame(height: 430)
                        .scaledToFill()
                        .scaleEffect(1.5)
            })
        }
    }
}

//struct GameHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameHeaderView(image: "https://cdn.vox-cdn.com/thumbor/sZbpcE4_0tjZTDN9xDCzZ2pp2AQ=/0x0:400x225/1200x800/filters:focal(168x81:232x145)/cdn.vox-cdn.com/uploads/chorus_image/image/67416047/1f9249103f371671071532e02e3ab39d2da49cbe_400x225.0.png", game: Game(id: 1, name: "Test", released: "2021-09-22", rating: 4.5, background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507802a67e8ac84a788.jpg", description: "Test", genres: ["Action", "Adventure"], platforms: ["PC", "PlayStation 4", "Xbox One"]))
//    }
//}