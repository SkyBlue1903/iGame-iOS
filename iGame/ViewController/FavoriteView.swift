//
//  FavoriteView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 19/10/22.
//

import SwiftUI
import SDWebImageSwiftUI


struct FavoriteView: View {

  @FetchRequest(sortDescriptors: []) var games: FetchedResults<SavedGame>
  @Environment(\.presentationMode) var presentationMode
  @Environment(\.managedObjectContext) var moc
  @State private var isPresentDeleteConfirmation = false
  @State private var saved: [SavedGame] = [SavedGame]()

  @State private var isRefreshed: Bool = false


  var body: some View {

    NavigationView {
      if games.isEmpty {
        VStack {
          Text("No favorite game")
                  .font(.title)
                  .fontWeight(.bold)
                  .padding(1.5)
          Text("Try add one!")
                  .font(.body)
        }
                .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                      presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
                .interactiveDismissDisabled()
                .navigationTitle("Favorite Games")
      } else {
        List {
            ForEach(saved, content: { game in
            NavigationLink(destination: GameDetailFavoriteView(game: Game(
                    id: Int(game.id),
                    name: game.name ?? "Untitled",
                    released: game.released ?? "Unknown",
                    rating: game.rating,
                    background_image: game.background_image ?? "",
                    description: game.game_description ?? "Lorem Ipsum",
                    website: game.website ?? "",
                    genres: game.genres as? [String] ?? [""],
                    publishers: game.publishers as? [String] ?? [""],
                    developers: game.developers as? [String] ?? [""],
                    platforms: game.platforms as? [String] ?? [""],
                    tags: game.tags as? [String] ?? [""],
                    ratings: game.ratings as? [String] ?? [""],
                    screenshots: game.screenshots as? [String] ?? [""]
            )
                    , isRefreshed: $isRefreshed
            )) {
              HStack {
                WebImage(url: URL(string: game.background_image ?? ""))
                        .resizable()
                        .placeholder {
                          Rectangle()
                        }
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                VStack(alignment: .leading) {
                  Text(game.name ?? "Untitled")
                          .font(.title2)
                          .fontWeight(.bold)
                  Text(game.released?.prefix(4) ?? "nil")
                          .font(.subheadline)
                          .foregroundColor(.gray)
                  Text("Rating: \(String(game.rating))")
                          .font(.subheadline)
                          .foregroundColor(.gray)
                }
              }
            }
          })
                  .onDelete(perform: removeGame)
        }
                .accentColor(isRefreshed ? .white : .black)
                .toolbar {
                  ToolbarItem(placement: .navigationBarLeading) {

                    Button(action: {
                      if !games.isEmpty {
                        isPresentDeleteConfirmation.toggle()
                      }
                    }) {
                      Image(systemName: "trash")
                              .foregroundColor(.red)
                              .alert(isPresented: $isPresentDeleteConfirmation) {
                                Alert(
                                        title: Text("Delete all favorite games?"),
                                        message: Text("This action cannot be undone."),
                                        primaryButton: .destructive(Text("Delete")) {
                                          for game in games {
                                            moc.delete(game)
                                          }
                                          try? moc.save()
                                        },
                                        secondaryButton: .cancel()
                                )
                              }
                    }
                  }
                }
                .toolbar {
                  EditButton()
                }
                .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                      presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
                .interactiveDismissDisabled()
                .navigationTitle("Favorite Games")
      }

    }
            .onAppear() {
              recalculateSaved()

            }
  }

  private func recalculateSaved() {
    saved = games.map {
      $0
    }
  }

  func removeGame(at offsets: IndexSet) {
    for index in offsets {
      let game = games[index]
      moc.delete(game)
    }
    do {
      try moc.save()
    } catch {
      print(error.localizedDescription)
    }
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteView()
  }
}
