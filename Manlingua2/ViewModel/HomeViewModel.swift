//
//  HomeViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
   @Published var currentStage: Stage = .open
   @Published var stories_example: [Story_Example] = []
   
   enum Stage {
      case open
      case home
      case story
      case dictionary
      case outlineStory
   }
   
   init(){
      loadStories()
   }
   
   func loadStories() {
      // Locate the JSON file in the bundle
      guard let url = Bundle.main.url(forResource: "Story_Example", withExtension: "json") else {
         print("File not found")
         return
      }
      
      do {
         // Load and decode the JSON data
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         self.stories_example = try decoder.decode([Story_Example].self, from: data)
      } catch {
         print("Failed to decode JSON: \(error.localizedDescription)")
      }
   }
   
   func switchStage(to stage: Stage) {
      currentStage = stage
//      print(currentStage)
   }
   
   func navigateToJourney(router: Router){
      router.push(.journeyPage)
   }
}
