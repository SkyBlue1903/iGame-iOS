//
//  RatingView.swift
//  iGame
//
// Created by Erlangga Anugrah Arifin on 22/09/22.
//

import SwiftUI

struct RatingView: View {
  var rating: Double
  var body: some View {
    HStack {
      ForEach(1..<6) { item in
        Image(systemName: item <= Int(rating) ? "star.fill" : item == Int(rating) + 1 && rating.truncatingRemainder(dividingBy: 1) != 0 ? "star.leadinghalf.fill" : "star")
                .foregroundColor(.yellow)
      }
    }
  }


}
