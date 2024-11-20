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
   @StateObject var router = Router()
   @StateObject var homeViewModel = HomeViewModel()
   @StateObject var storyViewModel = StoryViewModel()
   @StateObject var learnViewModel = LearnViewModel()
   @StateObject var challengeViewModel = ChallengeViewModel()
   @StateObject var flashcardViewModel = FlashcardViewModel()
   @StateObject var journeyViewModel = JourneyViewModel()
   @StateObject var importantNotesViewModel = ImportantNotesViewModel()
   @StateObject var swiftData = SwiftDataServices.shared
   @StateObject var audioController = AudioController.shared
   
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
               .onAppear{
                   UserNotificationManager.shared.requestNotificationPermission()
                   UserNotificationManager.shared.scheduleNotification()
               }
            
            //             FlashcardPageView(viewModel1: storyViewModel)
         }
         .environmentObject(router)
         .environmentObject(homeViewModel)
         .environmentObject(storyViewModel)
         .environmentObject(learnViewModel)
         .environmentObject(flashcardViewModel)
         .environmentObject(challengeViewModel)
         .environmentObject(journeyViewModel)
         .environmentObject(importantNotesViewModel)
         .onAppear(perform: {
            DispatchQueue.main.async{
               audioController.initializeAudioSessionAndRecorder()
            }
         })
      }
      
   }
}
