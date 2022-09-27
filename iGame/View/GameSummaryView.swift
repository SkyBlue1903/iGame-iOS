//
//  GameSummaryView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 27/09/22.
//

import SwiftUI

struct GameSummaryView: View {
    
    var game: Game
    var summaryInfo: [String] = ["Release date", "Developer", "Publisher", " Highlight review", "Genres"]
    
    var body: some View {
        GroupBox() {
            
        }
    }
}

//struct GameSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameSummaryView(game: Game(id: 1, name: "Test", released: "2021-09-22", rating: 4.5, background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507802a67e8ac84a788.jpg", description: "Test", genres: ["Action", "Adventure"], platforms: ["PC", "PlayStation 4", "Xbox One"]))
//    }
//}