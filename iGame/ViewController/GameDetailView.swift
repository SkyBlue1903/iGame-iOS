//
//  GameDetailView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameDetailView: View {

  var game: Game
  @State private var descIsExpanded = false

  @Environment(\.managedObjectContext) var moc

  var body: some View {

    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        VStack(alignment: .center, spacing: 20) {
          GameHeaderView(image: game.background_image, game: game)

          VStack(alignment: .leading, spacing: 15) {
            HStack {
              Text(game.name)
                      .font(.title)
                      .fontWeight(.heavy)
              Spacer()
              // add favorite icon
              Button(action: {
                // save game
                let newGame = SavedGame(context: moc)
                newGame.id = Int16(game.id)
                newGame.name = game.name
                try? moc.save()
              }) {
                Image(systemName: "heart")
                        .font(.title)
              }

            }
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
                if game.screenshots.isEmpty {
                  ProgressView()
                          .frame(width: 350, height: 350)
                          .cornerRadius(10)
                } else {
                  WebImage(url: URL(string: game.screenshots[index]))
                          .resizable()
                          .scaledToFill()
                          .frame(width: 350, height: 200)
                          .cornerRadius(15)
                          .padding(.horizontal)
                }
              }
            }
                    .frame(height: 200)
                    .padding(.top)
                    .tabViewStyle(PageTabViewStyle())

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
