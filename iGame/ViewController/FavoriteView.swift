//
//  FavoriteView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 19/10/22.
//

import SwiftUI

struct FavoriteView: View {
    
    @FetchRequest(sortDescriptors: []) var games: FetchedResults<SavedGame>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        NavigationView {
            if games.isEmpty {
                VStack {
                    Text("No favorite game")
                            .font(.title)
                    Text("Try add one!")
                            .font(.caption)
                }
                .navigationTitle("Favorite Games")
            } else {
                List {
                    ForEach(games) { game in
                        Text(game.name ?? "Unknown")
                    }
                }
                        .navigationTitle("Favorite Games")
            }

        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
