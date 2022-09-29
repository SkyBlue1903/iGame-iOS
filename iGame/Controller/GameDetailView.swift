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
                    GameHeaderView(image: game.background_image, game: game)

                    VStack(alignment: .leading, spacing: 15) {
                        Text(game.name)
                                .font(.title)
                                .fontWeight(.heavy)
                        HStack {
                            RatingView(rating: game.rating)
                            Text("(\(String(format: "%.1f", game.rating)))")
                                    .font(.subheadline)
                        }

                        GameSummaryView(game: game)

                        Text("Gameplay Screenshots")
                                .fontWeight(.bold)
                                .font(.system(.title2))
                        TabView {
                            ForEach(0..<game.screenshots.count) { index in
                                AsyncImage(url: URL(string: game.screenshots[index])!) { image in
                                    image.resizable()
                                            .scaledToFill()
                                            .frame(height: 200)
                                            .cornerRadius(15)
                                            .padding(.horizontal)
                                } placeholder: {
                                    ProgressView()
                                            .frame(height: 200)
                                            .scaleEffect(1.5)
                                }
                            }
                        }

                        Text("Description")
                                .fontWeight(.bold)
                        .font(.system(.title2))
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
                                .frame(height: 200)
                                .padding(.top)
                                .tabViewStyle(PageTabViewStyle())

                        WebsiteButtonView(game: game)
                                .padding(.top, 10)
                                .padding(.bottom, 40)
                    }
                            .padding(.horizontal, 20)
                }
                        .navigationBarTitle(game.name, displayMode: .inline)
                        .navigationBarHidden(true)
            }
                    .edgesIgnoringSafeArea(.top)
        }
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
                    .navigationTitle("Description")
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
