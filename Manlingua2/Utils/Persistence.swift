//
//  Persistence.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//
/*
import CoreData

class PersistenceController {
   static let shared = PersistenceController()
   
   static var preview: PersistenceController = {
      let result = PersistenceController(inMemory: true)
      let viewContext = result.container.viewContext
      for x in 0..<10 {
         let newFruit = Progress(context: viewContext)
//         newFruit.name = "Apple \(x)"
      }
      do {
         try viewContext.save()
      } catch {
         // Replace this implementation with code to handle the error appropriately.
         // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         let nsError = error as NSError
         fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      return result
   }()
   
   let container: NSPersistentContainer
   
   init(inMemory: Bool = false) {
      container = NSPersistentContainer(name: "Manlingua2")
      if inMemory {
         container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
      }
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      })
      container.viewContext.automaticallyMergesChangesFromParent = true
   }
   
//   static let shared = PersistenceController()
//   
//   @MainActor
//   static let preview: PersistenceController = {
//      let result = PersistenceController(inMemory: true)
//      let viewContext = result.container.viewContext
//      for _ in 0..<10 {
//         let newItem = Progress(context: viewContext)
//         newItem.latestStory = 1
//         newItem.latestSubchapter = 1
//      }
//      do {
//         try viewContext.save()
//      } catch {
//         // Replace this implementation with code to handle the error appropriately.
//         // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//         let nsError = error as NSError
//         fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//      }
//      return result
//   }()
//   
//   let container: NSPersistentCloudKitContainer
//   
//   init(inMemory: Bool = false) {
//      container = NSPersistentCloudKitContainer(name: "Manlingua2")
//      if inMemory {
//         container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
//      } else {
//         let storeDescription = container.persistentStoreDescriptions.first
//         
//         storeDescription?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
//         storeDescription?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.mproduction.Manlingua2")
//      }
//      
//      container.loadPersistentStores { _, error in
//         if let error = error as NSError? {
//            fatalError("Unresolved error \(error), \(error.userInfo)")
//         }
//      }
//      
//      NotificationCenter.default.addObserver(
//         self,
//         selector: #selector(self.storeRemoteChange),
//         name: .NSPersistentStoreRemoteChange,
//         object: container.persistentStoreCoordinator
//      )
//   }
//   
//   @objc private func storeRemoteChange(_ notification: Notification) {
//      let context = container.viewContext
//      context.perform {
//         // Refresh the context to pick up new changes
//         context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//         do {
//            try context.save()
//         } catch {
//            print("Failed to handle remote change: \(error)")
//         }
//      }
//   }
}
*/
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
//    @MainActor
//    static let preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = StoryProgress(context: viewContext)
////            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Manlingua2")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}


