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
        Divider().padding(.vertical, 3)
        VStack(alignment: .leading, spacing: 10) {
          HStack {
            Group {
              Image(systemName: "calendar")
              Text("Release Date")
                      .bold()
            }
            Spacer(minLength: 60)
            Text(game.released)
                    .multilineTextAlignment(.trailing)
          }
                  .padding(.vertical, 5)

          // ----------------------------------

          HStack {
            Group {
              Image(systemName: "gearshape.fill")
              Text("Developers")
                      .bold()
            }
            Spacer(minLength: 60)
            Text(game.developers.joined(separator: ", "))
                    .multilineTextAlignment(.trailing)
          }
                  .padding(.vertical, 5)

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
                  .padding(.vertical, 5)

          // ----------------------------------

          HStack {
            Group {
              Image(systemName: "quote.bubble.fill")
              Text("Highlight Reviews")
                      .bold()
            }
            Spacer(minLength: 60)

            VStack {
              ForEach((0...3), id: \.self) {
                  let tempArray = game.ratings[$0].components(separatedBy: " ")

                VStack(alignment: .trailing) {
                  if #available(iOS 16.0, *) {
                    Text("\(tempArray[0])".uppercased())
                            .multilineTextAlignment(.trailing)
                            .bold()
                  } else {
                    Text("\(tempArray[0])".uppercased())
                            .multilineTextAlignment(.trailing)
                  }
                  HStack {
                    Text("\(tempArray[1]) reviews")
                            .multilineTextAlignment(.trailing)
                    Text("(\((tempArray[2])))")
                            .multilineTextAlignment(.trailing)
                  }
                }
              }
            }
          }
                  .padding(.vertical, 5)

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
                  .padding(.vertical, 5)

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
                  .padding(.vertical, 5)

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
                  .padding(.vertical, 5)
        }
      }
    }
  }
}
