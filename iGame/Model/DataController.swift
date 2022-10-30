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

  func checkIfDataExists(id: Int64) -> Bool {
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

  func deleteData(id: Int64) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedGame")
    fetchRequest.predicate = NSPredicate(format: "id == %d", id)
    do {
      let test = try container.viewContext.fetch(fetchRequest)
      let objectToDelete = test[0] as! NSManagedObject
      container.viewContext.delete(objectToDelete)
      try container.viewContext.save()
    } catch {
      print("Error: \(error)")
    }
  }
}
