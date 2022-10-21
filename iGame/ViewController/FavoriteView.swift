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

  var body: some View {
    NavigationView {
      if games.isEmpty {
        VStack {
          Text("No favorite game")
                  .font(.title)
                  .padding(2.5)
          Text("Try add one!")
                  .font(.body)
        }
                .navigationTitle("Favorite Games")
      } else {
        List {
          ForEach(games) { game in
//                    NavigationLink(destination: GameDetailView(game: Game(
//                            id: Int(game.id),
//                            name: game.name ?? "Untitled",
//                            released: game.released ?? "Unknown",
//                            rating: game.rating ?? 0.0,
//                            background_image: game.background_image ?? "",
//                            description: game.game_description ?? "Lorem Ipsum",
//                            website: game.website ?? "",
//                            genres: game.genres as! [String] ?? ["Unknown"],
//                            publishers: game.publishers as! [String] ?? ["Unknown"],
//                            developers: game.developers as! [String] ?? ["Unknown"],
//                            platforms: game.platforms as! [String] ?? ["Unknown"],
//                            tags: game.tags as! [String] ?? ["Unknown"],
//                            ratings: game.ratings as! [String] ?? ["Unknown"],
//                            screenshots: game.screenshots as! [String] ?? ["Unknown"]
//                    ))) {
//                      let _ = print("Game name: \(game.name ?? "No name")")
//
//
//                    }
            let _ = print("Game Tags:", game.tags as! [String] ?? "No tags")
            VStack {
              Text(game.name!)
                      .font(.body)
                      .fontWeight(.heavy)
              ForEach(game.publishers as! [String], id: \.self) { tag in
                Text(tag)
                        .multilineTextAlignment(.leading)
                        .font(.caption)

              }
            }


          }
                  .onDelete(perform: removeGame)
        }
                .toolbar {
                  ToolbarItem(placement: .navigationBarLeading) {

                    Button(action: {
                      for game in games {
                        moc.delete(game)
                      }
                      try? moc.save()
                    }) {
                      Image(systemName: "trash")
                    }
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
