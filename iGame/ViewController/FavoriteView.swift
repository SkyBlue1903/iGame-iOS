//
//  FavoriteView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 19/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteView: View {

  @FetchRequest(sortDescriptors: []) var games: FetchedResults<SavedGame>
  @Environment(\.managedObjectContext) var moc
  @State private var isPresentDeleteConfirmation = false

  var body: some View {
    NavigationView {
      if games.isEmpty {
        VStack {
          Text("No favorite game")
                  .font(.title)
                  .fontWeight(.bold)
                  .padding(1.5)
          Text("Try add one!")
                  .font(.body)
        }
                .navigationTitle("Favorite Games")
      } else {
        List {
          ForEach(games) { game in
            NavigationLink(destination: GameDetailView(game: Game(
                    id: Int(game.id),
                    name: game.name ?? "Untitled",
                    released: game.released ?? "Unknown",
                    rating: game.rating ?? 0.0,
                    background_image: game.background_image ?? "",
                    description: game.game_description ?? "Lorem Ipsum",
                    website: game.website ?? "",
                    genres: game.genres as! [String] ?? ["Unknown"],
                    publishers: game.publishers as! [String] ?? ["Unknown"],
                    developers: game.developers as! [String] ?? ["Unknown"],
                    platforms: game.platforms as! [String] ?? ["Unknown"],
                    tags: game.tags as! [String] ?? ["Unknown"],
                    ratings: game.ratings as! [String] ?? ["Unknown"],
                    screenshots: game.screenshots as! [String] ?? ["Unknown"]
            ))) {
              let _ = print("Game Name: \(game.name ?? "No name")")
              let _ = print("Game Tags:", game.tags as! [String] ?? "No tags")
              HStack {
                WebImage(url: URL(string: game.background_image ?? ""))
                        .resizable()
                        .placeholder {
                          Rectangle()
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                VStack(alignment: .leading) {
                  Text(game.name ?? "Untitled")
                          .font(.title2)
                          .fontWeight(.bold)
                  Text(game.released!.prefix(4))
                          .font(.subheadline)
                          .foregroundColor(.gray)
                  Text("Rating: \(game.rating ?? 0.0)")
                          .font(.subheadline)
                          .foregroundColor(.gray)
                }
              }
            }
          }
                  .onDelete(perform: removeGame)
        }
                .toolbar {
                  ToolbarItem(placement: .navigationBarLeading) {

                    Button(action: {
                      if !games.isEmpty {
                        isPresentDeleteConfirmation.toggle()
                      }
                    }) {
                      Image(systemName: "trash")
                              .alert(isPresented: $isPresentDeleteConfirmation) {
                                Alert(
                                        title: Text("Delete all favorite games?"),
                                        message: Text("This action cannot be undone."),
                                        primaryButton: .destructive(Text("Delete")) {
                                          for game in games {
                                            moc.delete(game)
                                          }
                                          try? moc.save()
                                        },
                                        secondaryButton: .cancel()
                                )
                              }
                    }
                    //
                  }
                }
                .toolbar {
                  EditButton()
                }
                .navigationTitle("Favorite Games")
      }

    }
  }

  func removeGame(at offsets: IndexSet) {
    for index in offsets {
      let game = games[index]
      moc.delete(game)
    }
    do {
      try moc.save()
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteView()
  }
}
