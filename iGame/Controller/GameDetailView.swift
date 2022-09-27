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
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    // HEADER
                    GameHeaderView(image: game.background_image, game: game)

                    VStack(alignment: .leading, spacing: 20) {
                        // TITLE
                        Text(game.name)
                                .font(.title)
                                .fontWeight(.heavy)

                        //
                        Text(game.released.prefix(4))
                                .font(.title2)
                                .multilineTextAlignment(.leading)

//                        // NUTRIENTS
//                        FruitNutrientsView(fruit: fruit)
//
//                        // SUBHEADLINE
//                        Text("Learn more about \(fruit.title)".uppercased())
//                                .fontWeight(.bold)
//                                .foregroundColor(fruit.gradientColors[1])
//
//                        // DESCRIPTION
//                        Text(fruit.description)
//                                .multilineTextAlignment(.leading)
//
//                        // LINK
//                        SourceLinkView()
//                                .padding(.top, 10)
//                                .padding(.bottom, 40)
                    } //: VSTACK
                            .padding(.horizontal, 20)
                            .frame(maxWidth: 640, alignment: .center)
                } //: VSTACK
                        .navigationBarTitle(game.name, displayMode: .inline)
                        .navigationBarHidden(true)
            } //: SCROLL
                    .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }


//}

//struct GameDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameDetailView(game: Game(id: 1, name: "Test", released: "2021-09-22", rating: 4.5, background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507802a67e8ac84a788.jpg", description: "Test", genres: ["Action", "Adventure"], platforms: ["PC", "PlayStation 4", "Xbox One"]))
//    }
//}
