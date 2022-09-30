//
//  ContentView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI
import SDWebImageSwiftUI


struct ContentView: View {

    @State private var profileIsExpanded = false
    @ObservedObject var fetchGame = FetchGame()
    @State var searchQuery = ""

    var body: some View {
        NavigationView {
            if searchQuery == "" {
                List(fetchGame.gamesData) { game in
                    NavigationLink(destination: GameDetailView(game: game)) {
                        HStack {
                            WebImage(url: URL(string: game.background_image))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)

                            VStack(alignment: .leading, spacing: 5) {
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
                        .navigationBarItems(trailing: Button("Profile") {
                            profileIsExpanded.toggle()
                        }.sheet(isPresented: $profileIsExpanded) {
                            ProfileView()
                        })
            } else {
                List {
                    ForEach(searchResults, id: \.self) {
                        Text($0)
                    }
                }
                        .navigationTitle("Search Results")
            }
        }
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
    }

    var searchResults: [String] {
        if searchQuery.isEmpty {
            return fetchGame.gamesData.map { $0.name }
        } else {
            return fetchGame.gamesData.filter { $0.name.contains(searchQuery) }.map { $0.name }
        }
    }

}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
