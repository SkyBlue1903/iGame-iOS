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
  @State var isFavorite = false
  @State private var showToast = false


  var body: some View {

//    var isFavorite = DataController().checkIfDataExists(id: Int64(game.id))

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

              Button(action: {
                isFavorite.toggle()
                if isFavorite {
                  print("\(game.name) saved!")
                } else {
                  print("\(game.name) deleted :(")
                }
              }, label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(isFavorite ? .red : .gray)
              })


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
            ScrollView(.horizontal, showsIndicators: true) {
              HStack(alignment: .center, spacing: 15) {
                ForEach(0..<game.screenshots.count) { index in
                  if game.screenshots.isEmpty {
                    ProgressView()
                            .frame(width: 350, height: 350)
                            .cornerRadius(10)
                  } else {
                    WebImage(url: URL(string: game.screenshots[index]))
                            .resizable()
                            .scaledToFit()
                            .frame(height: 175)
                            .cornerRadius(15)
                  }
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
            WebsiteButtonView(game: game)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
          }
                  .padding(.horizontal, 20)
                  .frame(maxWidth: 640, alignment: .center)
        }
                .navigationBarTitle(game.name, displayMode: .inline)
                .navigationBarHidden(true)
      }
              .edgesIgnoringSafeArea(.top)
    }
            .toast(isPresenting: $showToast, duration: 5) {
              AlertToast(displayMode: .banner(.pop), type: .regular, title: "Success", subTitle: "Go to \"Star\" tab button to view")
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear {
              isFavorite = DataController().checkIfDataExists(id: Int64(game.id))
            }
  }

  func saveANewGame() {
    let newGame = SavedGame(context: moc)
    newGame.id = Int64(game.id)
    newGame.name = game.name
    newGame.background_image = game.background_image
    newGame.released = game.released
    newGame.rating = game.rating
    newGame.game_description = game.description
    newGame.website = game.website
    newGame.developers = game.developers as NSObject
    newGame.publishers = game.publishers as NSObject
    newGame.genres = game.genres as NSObject
    newGame.platforms = game.platforms as NSObject
    newGame.screenshots = game.screenshots as NSObject
    newGame.tags = game.tags as NSObject
    newGame.ratings = game.ratings as NSObject
  }

  func deleteAGame() {
    let results = DataController().checkIfDataExists(id: Int64(game.id))
    if results {
      DataController().deleteData(id: Int64(game.id))
    }
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

// preview

struct GameDetailView_Previews: PreviewProvider {
  static var previews: some View {
    GameDetailView(game: Game(id: 123, name: "asad", released: "2022", rating: 4.65, background_image: "ds", description: "asd", website: "asda", genres: ["12"], publishers: ["12"], developers: ["12"], platforms: ["123"], tags: ["123"], ratings: ["1231212312312312", "123123123123123", "13123131312"], screenshots: ["123123"]))
  }
}
