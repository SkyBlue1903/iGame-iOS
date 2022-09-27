//
//  GameDetailView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI

struct GameDetailView: View {
    
    var game: Game
    @State private var descIsExpanded = false

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
                        Text(game.released.prefix(4))
                                .font(.title2)
                                .multilineTextAlignment(.leading)
                        HStack {
                            RatingView(rating: game.rating)
                            Text("(\(String(format: "%.1f", game.rating)))")
                                    .font(.subheadline)
                        }
//                        Text(game.platforms.joined(separator: ", "))
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                                .multilineTextAlignment(.leading)
//                                .fixedSize(horizontal: true, vertical: false)


                        Text("Description".uppercased())
                                .fontWeight(.bold)
//
//                        // DESCRIPTION
                        VStack(alignment: .trailing, spacing: 5) {
                            Text(game.description)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(5)
                            Button("Read more") {
                                descIsExpanded.toggle()
                            }
                                    .sheet(isPresented: $descIsExpanded) {
                                        GameDescriptionView(game: game)
                                    }
                        }

//
//                        // LINK
//                        SourceLinkView()
//                                .padding(.top, 10)
//                                .padding(.bottom, 40)
                    } //: VSTACK
                            .padding(.horizontal, 20)
//                            .frame(maxWidth: 640, alignment: .center)
                } //: VSTACK
                        .navigationBarTitle(game.name, displayMode: .inline)
                        .navigationBarHidden(true)
            } //: SCROLL
                    .edgesIgnoringSafeArea(.top)
        } //: NAVIGATION
                .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct GameDescriptionView: View {

    @Environment(\.dismiss) var dismiss
    var game: Game

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                Text(game.description)
                        .multilineTextAlignment(.leading)
                        .padding()
            }
                    .navigationTitle("\(game.name) Description")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Done") {
                                dismiss()
                            }
                        }
                    }
        }


    }
}

//}

//struct GameDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameDetailView()
//    }
//}
