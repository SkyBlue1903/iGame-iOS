//
//  GameHeaderView.swift
//  iGame
//
//  Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameHeaderView: View {
  var image: String
  var game: Game
  var body: some View {
    ZStack {
      // load image using sdwebimage
      WebImage(url: URL(string: image))
              .resizable()
              .scaledToFill()
              .frame(width: UIScreen.main.bounds.width, height: 430)
              .clipped()
    }
  }
}
