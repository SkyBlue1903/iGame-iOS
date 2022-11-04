//
//  Extensions.swift
//  iGame
//
// Created by Erlangga Anugrah Arifin on 25/10/22.
//

import Foundation

extension Date {
  static var tomorrow: Date {
    Date().dayAfter
  }
  static var today: Date {
    Date()
  }
  var dayAfter: Date {
    Calendar.current.date(byAdding: .day, value: 1, to: Date())!
  }
}
