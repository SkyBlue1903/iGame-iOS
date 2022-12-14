//
//  Profile.swift
//  iGame
//
// Created by Erlangga Anugrah Arifin on 22/10/22.
//

import Foundation

struct Profile {

  static func getProfile() {
    _ = UserDefaults.standard.string(forKey: "Username") ?? ""
    _ = UserDefaults.standard.string(forKey: "Fullname") ?? ""
    _ = UserDefaults.standard.string(forKey: "Job") ?? ""
  }

  static func saveProfile(username: String, fullname: String, job: String) {
    UserDefaults.standard.set(username, forKey: "Username")
    UserDefaults.standard.set(fullname, forKey: "Fullname")
    UserDefaults.standard.set(job, forKey: "Job")
  }

  static func resetProfile() {
    UserDefaults.standard.removeObject(forKey: "Username")
    UserDefaults.standard.removeObject(forKey: "Fullname")
    UserDefaults.standard.removeObject(forKey: "Job")
  }
}
