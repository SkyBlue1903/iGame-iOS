//
//  API.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON
import SDWebImage

struct Game: Codable, Identifiable {

  let id: Int
  let name: String
  let released: String
  let rating: Double
  let background_image: String

  let description: String
  let website: String
  let genres: [String]
  let publishers: [String]
  let developers: [String]
  let platforms: [String]
  let tags: [String]
  let ratings: [String]
  let screenshots: [String]


}

class FetchGame: ObservableObject {
  @Published var gamesData = [Game]()

  init() {
    let url = "https://api.rawg.io/api/games?key=51dba43fdb814742bc67c11eec616afa"
    AF.request(url).responseJSON { [self] response in
      let result = response.data
      if result != nil {
        let json = JSON(result!)
        let data = json["results"].arrayValue
        for i in data {
          let id = i["id"].intValue
          let name = i["name"].stringValue
          let released = i["released"].stringValue
          let rating = i["rating"].doubleValue
          let background_image = i["background_image"].stringValue

          fetchGameDetail(id: id, name: name, released: released, rating: rating, background_image: background_image)

          // Game Detail Fetch URL

        }
      }
    }

  }

  func fetchGameDetail(id: Int, name: String, released: String, rating: Double, background_image: String) {
    let detailURL = "https://api.rawg.io/api/games/\(id)?key=51dba43fdb814742bc67c11eec616afa"
    AF.request(detailURL).responseJSON { response in
      let result = response.data
      if result != nil {
        let json = JSON(result!)
        let description = json["description_raw"].stringValue
        let website = json["website"].stringValue
        let genres = json["genres"].arrayValue.map({ $0["name"].stringValue })
        let publishers = json["publishers"].arrayValue.map({ $0["name"].stringValue })
        let developers = json["developers"].arrayValue.map({ $0["name"].stringValue })
        let platforms = json["platforms"].arrayValue.map({ $0["platform"]["name"].stringValue })
        let tags = json["tags"].arrayValue.map({ $0["name"].stringValue })
        let ratings = json["ratings"].arrayValue.map({ "\($0["title"].stringValue) \($0["count"].intValue) \($0["percent"].intValue)%" })
//                            print(ratings)


        // Game screenshots
        let detailURL = "https://api.rawg.io/api/games/\(id)/screenshots?key=51dba43fdb814742bc67c11eec616afa"

        AF.request(detailURL).responseJSON { response in
          let result = response.data
          if result != nil {
            let json = JSON(result!)
            let screenshots = json["results"].arrayValue.map({ $0["image"].stringValue })
//                                    print(screenshots)

            DispatchQueue.main.async {
              self.gamesData.append(Game(id: id, name: name, released: released, rating: rating, background_image: background_image, description: description, website: website, genres: genres, publishers: publishers, developers: developers, platforms: platforms, tags: tags, ratings: ratings, screenshots: screenshots))
            }
          }
        }

      }
    }
  }

  func getDescription(id: Int) -> String {

    let game = gamesData
    let gameDescription = game.first(where: { $0.id == id })?.description
    print("Game description: ", gameDescription)
    return gameDescription ?? ""
  }

  func getWebsite(id: Int) -> String {
    let game = gamesData
    let gameWebsite = game.first(where: { $0.id == id })?.website
    return gameWebsite ?? ""
  }

  func getGenres(id: Int) -> [String] {
    let game = gamesData
    let gameGenres = game.first(where: { $0.id == id })?.genres
    return gameGenres ?? []
  }

  func getPublishers(id: Int) -> [String] {
    let game = gamesData
    let gamePublishers = game.first(where: { $0.id == id })?.publishers
    return gamePublishers ?? []
  }

  func getDevelopers(id: Int) -> [String] {
    let game = gamesData
    let gameDevelopers = game.first(where: { $0.id == id })?.developers
    return gameDevelopers ?? []
  }

  func getPlatforms(id: Int) -> [String] {
    let game = gamesData
    let gamePlatforms = game.first(where: { $0.id == id })?.platforms
    return gamePlatforms ?? []
  }

  func getTags(id: Int) -> [String] {
    let game = gamesData
    let gameTags = game.first(where: { $0.id == id })?.tags
    return gameTags ?? []
  }

  func getRatings(id: Int) -> [String] {
    let game = gamesData
    let gameRatings = game.first(where: { $0.id == id })?.ratings
    return gameRatings ?? []
  }

  func getScreenshots(id: Int) -> [String] {
    let game = gamesData
    let gameScreenshots = game.first(where: { $0.id == id })?.screenshots
    return gameScreenshots ?? []
  }
}
