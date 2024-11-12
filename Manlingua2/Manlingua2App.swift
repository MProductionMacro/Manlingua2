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
   @StateObject var challengeViewModel = ChallengeViewModel()
   @StateObject var flashcardViewModel = FlashcardViewModel()
   @StateObject var journeyViewModel = JourneyViewModel()
   @StateObject var importantNotesViewModel = ImportantNotesViewModel()
   @StateObject var coreData = CoreDataSingleton.shared
   @StateObject var swiftData = SwiftDataServices.shared
   
   init() {
      FirebaseApp.configure()
   }
   
   var body: some Scene {
      WindowGroup {
         NavigationStack(path: $router.path){
            EmptyView()
               .navigationDestination(for: Screen.self) { screen in
                  router.build(screen)
               }
            
            //             FlashcardPageView(viewModel1: storyViewModel)
         }
         .environment(\.managedObjectContext, persistenceController.container.viewContext)
         .environmentObject(router)
         .environmentObject(homeViewModel)
         .environmentObject(storyViewModel)
         .environmentObject(learnViewModel)
         .environmentObject(flashcardViewModel)
         .environmentObject(challengeViewModel)
         .environmentObject(journeyViewModel)
         .environmentObject(importantNotesViewModel)
         //.preferredColorScheme(.light)
      }
      
   }
}
