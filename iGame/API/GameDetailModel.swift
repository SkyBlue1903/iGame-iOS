//
// Created by Erlangga Anugrah Arifin on 22/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GameDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let released: String
    let rating: Double
    let background_image: String
    let description: String
    let website: String
    let genres: [String]
    let tags: [String]
    let platforms: [String]
}

struct GameDetailModel {
    func fetchGameDetail(id: Int, completion: @escaping (GameDetail) -> ()) {
        let url = "https://api.rawg.io/api/games/\(id)?key=51dba43fdb814742bc67c11eec616afa"
        AF.request(url).responseJSON { response in
            let result = response.data
            if result != nil {
                let json = JSON(result!)
                let id = json["id"].intValue
                let name = json["name"].stringValue
                let released = json["released"].stringValue
                let rating = json["rating"].doubleValue
                let background_image = json["background_image"].stringValue
                let description = json["description"].stringValue
                let website = json["website"].stringValue
                let genres = json["genres"].arrayValue.map({$0["name"].stringValue})
                let tags = json["tags"].arrayValue.map({$0["name"].stringValue})
                let platforms = json["platforms"].arrayValue.map({$0["platform"]["name"].stringValue})

                let newGame = GameDetail(id: id, name: name, released: released, rating: rating, background_image: background_image, description: description, website: website, genres: genres, tags: tags, platforms: platforms)
                completion(newGame)
            }
        }
    }
}