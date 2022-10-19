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
}
