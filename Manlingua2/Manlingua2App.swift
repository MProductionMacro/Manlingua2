//
//  Manlingua2App.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct Manlingua2App: App {
   let persistenceController = PersistenceController.shared
   @StateObject var router = Router()
   @StateObject var homeViewModel = HomeViewModel()
   @StateObject var storyViewModel = StoryViewModel()
   @StateObject var learnViewModel = LearnViewModel()
   
   init() {
      FirebaseApp.configure()
   }
   
   var body: some Scene {
      WindowGroup {
         NavigationStack(path: $router.path){
             /*
            EmptyView()
               .navigationDestination(for: Screen.self) { screen in
                  router.build(screen)
               }
            */
             FlashcardPageView(viewModel1: storyViewModel)
         }
         .environment(\.managedObjectContext, persistenceController.container.viewContext)
         .environmentObject(router)
         .environmentObject(homeViewModel)
         .environmentObject(storyViewModel)
         .environmentObject(learnViewModel)
         .environmentObject(FlashcardViewModel())
         .onAppear {
            StoryProgressManager.unlockFirstChapterIfNeeded()
         }
         //         SidebarButton()
      }
      
   }
}
