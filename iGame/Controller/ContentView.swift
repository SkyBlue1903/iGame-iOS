//
//  ContentView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var fetchGame = FetchGame()

    var body: some View {
        NavigationView {
            List(fetchGame.gamesData) { game in
                NavigationLink(destination: GameDetailView(game: game)) {
                    HStack {
                        AsyncImage(url: URL(string: game.background_image)!) { image in
                            image.resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                                    .frame(width: 100, height: 100)
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
                        }
                    }
                }
            }
            .navigationTitle("iGame")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
