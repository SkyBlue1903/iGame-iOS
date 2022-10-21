//
//  GameDetailView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast

struct GameDetailView: View {

  var game: Game
  @State private var descIsExpanded = false

  @Environment(\.managedObjectContext) var moc
  @State private var isFavorite = false
  @State private var showToast = false


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
              var results = DataController().checkIfDataExists(id: Int16(game.id))
              if !results && !isFavorite {
                Button(action: {
                  showToast.toggle()
                  self.isFavorite.toggle()
                  let newGame = SavedGame(context: moc)
                  newGame.id = Int16(game.id)
                  newGame.name = game.name
                  newGame.background_image = game.background_image
                  newGame.released = game.released
                  newGame.rating = game.rating
                  let _ = print("Name: \(game.name ?? "No name")")
                  let _ = print("Tags: \(game.tags as NSObject)")
                  newGame.game_description = game.description
                  newGame.website = game.website
                  newGame.developers = game.developers as NSObject
                  newGame.publishers = game.publishers as NSObject
                  newGame.genres = game.genres as NSObject
                  newGame.platforms = game.platforms as NSObject
                  newGame.screenshots = game.screenshots as NSObject
                  newGame.tags = game.tags as NSObject
                  newGame.ratings = game.ratings as NSObject
                  try? moc.save()

                }) {
                  Image(systemName: "star")
                          .font(.title)
                }
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
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
            .toast(isPresenting: $showToast, duration: 5) {
              AlertToast(displayMode: .banner(.pop), type: .regular, title: "Success", subTitle: "Go back and press \"Star card\" button to view")
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
