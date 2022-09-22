//
//  GameDetailView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI

struct GameDetailView: View {
    
    var game: Game

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: game.background_image)!) { image in
                image.resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(10)
            } placeholder: {
                ProgressView()
                        .frame(width: 250, height: 250)
                        .scaleEffect(1.5)
            }
            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)
                Text(game.released.prefix(4))
                    .font(.subheadline)
                HStack {
                    RatingView(rating: game.rating)
                    Text("(\(String(format: "%.1f", game.rating)))")
                        .font(.subheadline)
                }
                Text("Genres: \(game.genres.joined(separator: ", "))")
                    .font(.subheadline)
                Text("Platforms: \(game.platforms.joined(separator: ", "))")
                    .font(.subheadline)
                Text(game.description)
                    .font(.subheadline)
                    .padding(.top)
            }
        }
        .padding()
        .navigationTitle("Detail")
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: Game(id: 1, name: "Test", released: "2021-09-22", rating: 4.5, background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507802a67e8ac84a788.jpg", description: "Test", genres: ["Action", "Adventure"], platforms: ["PC", "PlayStation 4", "Xbox One"]))
    }
}
