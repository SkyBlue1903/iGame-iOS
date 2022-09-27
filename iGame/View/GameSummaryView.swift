//
//  GameSummaryView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 27/09/22.
//

import SwiftUI

struct GameSummaryView: View {

    var game: Game

    var body: some View {
        GroupBox() {
            DisclosureGroup("Game Summary") {
                Divider().padding(.vertical,3)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Group {
                            Image(systemName: "calendar")
                            Text("Release date")
                                    .bold()
                        }
                        Spacer(minLength: 60)
                        Text(game.released)
                                .multilineTextAlignment(.trailing)
                    }
                            .padding(.vertical, 3)

                    // ----------------------------------

                    HStack {
                        Group {
                            Image(systemName: "gearshape.2.fill")
                            Text("Developers")
                                    .bold()
                        }
                        Spacer(minLength: 60)
                        Text(game.developers.joined(separator: ", "))
                                .multilineTextAlignment(.trailing)
                    }
                            .padding(.vertical, 3)

                    // ----------------------------------

                    HStack {
                        Group {
                            Image(systemName: "square.and.arrow.up.fill")
                            Text("Publishers")
                                    .bold()
                        }
                        Spacer(minLength: 60)
                        Text(game.publishers.joined(separator: ", "))
                                .multilineTextAlignment(.trailing)
                    }
                            .padding(.vertical, 3)

                    // ----------------------------------

                    HStack {
                        Group {
                            Image(systemName: "quote.bubble.fill")
                            Text("Highlight Reviews")
                                    .bold()
                        }
                        Spacer(minLength: 60)
                        Text("Unavailable")
                                .multilineTextAlignment(.trailing)
                    }
                            .padding(.vertical, 3)

                    // ----------------------------------

                    HStack {
                        Group {
                            Image(systemName: "gamecontroller.fill")
                            Text("Platforms")
                                    .bold()
                        }
                        Spacer(minLength: 60)
                        Text(game.platforms.joined(separator: ", "))
                                .multilineTextAlignment(.trailing)
                    }
                            .padding(.vertical, 3)

                    // ----------------------------------

                    HStack {
                        Group {
                            Image(systemName: "rectangle.stack.fill")
                            Text("Genres")
                                    .bold()
                        }
                        Spacer(minLength: 60)
                        Text(game.genres.joined(separator: ", "))
                                .multilineTextAlignment(.trailing)
                    }
                            .padding(.vertical, 3)

                    // ----------------------------------

                    HStack {
                        Group {
                            Image(systemName: "tag.fill")
                            Text("Tags")
                                    .bold()
                        }
                        Spacer(minLength: 60)
                        Text(game.tags.joined(separator: ", "))
                                .multilineTextAlignment(.trailing)
                    }
                            .padding(.vertical, 3)
                }
            }
        }
    }
}


//struct GameSummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameSummaryView(game: Game(id: 1, name: "Test", released: "2021-09-22", rating: 4.5, background_image: "https://media.rawg.io/media/games/84d/84da2ac3fdfc6507802a67e8ac84a788.jpg", description: "Test", genres: ["Action", "Adventure"], platforms: ["PC", "PlayStation 4", "Xbox One"]))
//    }
//}