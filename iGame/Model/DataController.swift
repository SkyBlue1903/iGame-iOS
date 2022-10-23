//
// Created by Erlangga Anugrah Arifin on 19/10/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {

  let container = NSPersistentContainer(name: "FavoriteGames") // load from .xcdatamodeld file

  init() {
    container.loadPersistentStores { storeDescription, error in
      if let error = error {
        print("Fatal error loading store: \(error.localizedDescription)")
      }
    }
  }

  func checkIfDataExists(id: Int16) -> Bool {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedGame")
    fetchRequest.predicate = NSPredicate(format: "id == %d", id)
    do {
      let count = try container.viewContext.count(for: fetchRequest)
      if count == 0 {
        return false
      }
    } catch {
      print("Error: \(error)")
    }
    return true
  }

}
