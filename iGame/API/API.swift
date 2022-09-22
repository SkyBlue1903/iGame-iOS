//
//  API.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let rating: Double
    let background_image: String
    let description: String
    let genres: [String]
    let platforms: [String]
}

class FetchGame: ObservableObject {
        @Published var gamesData = [Game]()

    init() {
        let url = "https://api.rawg.io/api/games?key=51dba43fdb814742bc67c11eec616afa&page_size=3"
        AF.request(url).responseJSON { response in
            let result = response.data
            if result != nil {
                let json = JSON(result!)
                let data = json["results"].arrayValue
                for i in data {
                    print(i)
                    let id = i["id"].intValue
                    let name = i["name"].stringValue
                    let released = i["released"].stringValue
                    let rating = i["rating"].doubleValue
                    let background_image = i["background_image"].stringValue
                    let description = i["description"].stringValue
                    let genres = i["genres"].arrayValue.map({$0["name"].stringValue})
                    let platforms = i["platforms"].arrayValue.map({$0["platform"]["name"].stringValue})

                    let newGame = Game(id: id, name: name, released: released, rating: rating, background_image: background_image, description: description, genres: genres, platforms: platforms)
                    self.gamesData.append(newGame)
                }
            }
        }
    }
}