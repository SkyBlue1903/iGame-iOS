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
  @State private var favoriteIsExpanded = false
  @ObservedObject var fetchGame = FetchGame()
  @State var searchQuery = ""
  let notification = NotificationHandler()

//  @State private var isRefreshed: Bool = false

  var body: some View {
    if fetchGame.gamesData.isEmpty {
//        let _ = notification.checkPermission()
      NavigationView {
        ProgressView()
                .navigationTitle("iGame")

      }
    } else {
      NavigationView {
//        let _ = notification.checkPermission()
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

                  .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                      Button(action: {
                        favoriteIsExpanded.toggle()
                      }) {
                        Image(systemName: "star")
                      }
                              .sheet(isPresented: $favoriteIsExpanded) {
                                FavoriteView()
                              }
                    }
                  }
        } else {
          List {
            Text("Search results for: \(searchQuery)")
            ForEach(fetchGame.gamesData.filter({ searchQuery.isEmpty ? true : $0.name.lowercased().contains(searchQuery.lowercased()) })) { game in
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
          }
                  .navigationTitle("Search Results")
        }
      }
              .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
    }

  }


}

