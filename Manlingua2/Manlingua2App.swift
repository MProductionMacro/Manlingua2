//
//  Manlingua2App.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

@main
struct Manlingua2App: App {
   let persistenceController = PersistenceController.shared
   @StateObject var router = Router()
   @StateObject var homeViewModel = HomeViewModel()
   @StateObject var storyViewModel = StoryViewModel()
   @StateObject var learnViewModel = LearnViewModel()
   
   var body: some Scene {
      WindowGroup {
         NavigationStack(path: $router.path){
            EmptyView()
               .navigationDestination(for: Screen.self) { screen in
                  router.build(screen)
               }
         }
         .environment(\.managedObjectContext, persistenceController.container.viewContext)
         .environmentObject(router)
         .environmentObject(homeViewModel)
         .environmentObject(storyViewModel)
         .environmentObject(learnViewModel)
      }
   }
}
