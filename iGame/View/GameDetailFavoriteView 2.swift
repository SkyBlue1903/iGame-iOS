//
//  GameDetailView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 04/11/22.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast

struct GameDetailFavoriteView: View {

  var game: Game
  @State private var descIsExpanded = false

  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismiss
  @State var isFavorite = false
  @State private var showToast = false

  @Binding var isRefreshed: Bool


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
                ForEach(0..<game.screenshots.count, id: \.self) { index in
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
            .navigationViewStyle(StackNavigationViewStyle())
  }

}


struct GameDescriptionFavoriteView: View {

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

struct GameDetailFavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    GameDetailView(game: Game(id: 123, name: "Lorem Ipsum", released: "2022", rating: 4.65, background_image: "ds", description: "asd", website: "asda", genres: ["12"], publishers: ["12"], developers: ["12"], platforms: ["123"], tags: ["123"], ratings: ["1231212312312312", "123123123123123", "13123131312"], screenshots: ["123123"]), isFavorite: false)
  }
}
