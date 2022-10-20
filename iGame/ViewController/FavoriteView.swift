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
//                        VStack {
//                            Text(game.name ?? "Unknown")
//                            Text(game.id.description)
//                        }

//                        NavigationLink(destination: GameDetailView(game: game)) {
                            HStack {
                                WebImage(url: URL(string: game.background_image ?? "https://raw.githubusercontent.com/koehlersimon/fallback/master/Resources/Public/Images/placeholder.jpg"))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(15)

                                VStack(alignment: .leading, spacing: 5) {
                                    Text(game.name ?? "Unknown")
                                            .font(.headline)
                                    Text(game.released ?? String("Unkown"))
                                            .font(.subheadline)
                                    HStack {
                                        RatingView(rating: game.rating ?? 0)
                                        Text("(\(String(format: "%.1f", game.rating)))")
                                                .font(.subheadline)
                                    }
                                }
                            }
                        }
//                    }
                            .onDelete(perform: removeGame)
                }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {

                                Button(action: {
                                    // delete all
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
