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
    let url = "https://api.rawg.io/api/games?key=75d4e36b70a74195a900cf2b336721c2"
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


        }
      }
    }

  }

  func fetchGameDetail(id: Int, name: String, released: String, rating: Double, background_image: String) {
    let detailURL = "https://api.rawg.io/api/games/\(id)?key=75d4e36b70a74195a900cf2b336721c2"
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


        // Game screenshots
        let detailURL = "https://api.rawg.io/api/games/\(id)/screenshots?key=75d4e36b70a74195a900cf2b336721c2"

        AF.request(detailURL).responseJSON { response in
          let result = response.data
          if result != nil {
            let json = JSON(result!)
            let screenshots = json["results"].arrayValue.map({ $0["image"].stringValue })

            DispatchQueue.main.async {
              self.gamesData.append(Game(id: id, name: name, released: released, rating: rating, background_image: background_image, description: description, website: website, genres: genres, publishers: publishers, developers: developers, platforms: platforms, tags: tags, ratings: ratings, screenshots: screenshots))
            }
          }
        }

      }
    }
  }
}
