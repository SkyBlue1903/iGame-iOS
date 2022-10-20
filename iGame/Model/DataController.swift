//
// Created by Erlangga Anugrah Arifin on 19/10/22.
//

import CoreData
import Foundation

class DataController:ObservableObject {
//  let container:NSPersistentContainer
//
//    var viewContext:NSManagedObjectContext {
//        return container.viewContext
//    }
//
//    init(inMemory:Bool = false) {
//        container = NSPersistentContainer(name: "iGame")
//
//        if inMemory {
//            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//        }
//
//        container.loadPersistentStores { storeDescription, error in
//            if let error = error {
//                fatalError("Fatal error loading store: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func save() {
//        if viewContext.hasChanges {
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

  let container = NSPersistentContainer(name: "FavoriteGames") // load from .xcdatamodeld file

  init() {
    container.loadPersistentStores { storeDescription, error in
      if let error = error {
        print("Fatal error loading store: \(error.localizedDescription)")
      }
    }
  }

  // check data if already exists
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
