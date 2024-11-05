//
//  Persistence.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import CoreData

class PersistenceController {
   static let shared = PersistenceController()
   
   @MainActor
   static let preview: PersistenceController = {
      let result = PersistenceController(inMemory: true)
      let viewContext = result.container.viewContext
      for _ in 0..<10 {
         let newItem = Progress(context: viewContext)
         newItem.latestStory = 1
         newItem.latestSubchapter = 1
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
   
   let container: NSPersistentCloudKitContainer
   
   init(inMemory: Bool = false) {
      container = NSPersistentCloudKitContainer(name: "Manlingua2")
      if inMemory {
         container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
      } else {
         let storeDescription = container.persistentStoreDescriptions.first
         
         storeDescription?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
         storeDescription?.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.mproduction.Manlingua2")
      }
      
      container.loadPersistentStores { _, error in
         if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      }
      
      NotificationCenter.default.addObserver(
         self,
         selector: #selector(self.storeRemoteChange),
         name: .NSPersistentStoreRemoteChange,
         object: container.persistentStoreCoordinator
      )
   }
   
   @objc private func storeRemoteChange(_ notification: Notification) {
      let context = container.viewContext
      context.perform {
         // Refresh the context to pick up new changes
         context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
         do {
            try context.save()
         } catch {
            print("Failed to handle remote change: \(error)")
         }
      }
   }
}
