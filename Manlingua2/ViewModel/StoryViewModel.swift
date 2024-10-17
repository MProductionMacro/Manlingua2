//
//  StoryViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import SwiftUI
import Combine

class StoryViewModel: ObservableObject {
   //TODO: Perbaikin VM nya (quizView, quizView2, toneView, convView, recall)
   @Published var chat_example: [Chat_Example] = []
   @Published var currentStoryIndex = 0
   @Published var currentOnboardingIndex = 0
   @Published var currentFlashcardIndex = 0
   @Published var currentQuiz1Index = 0
   @Published var currentQuiz2Index = 0
   @Published var currentToneTestIndex = 0
   @Published var currentConversationIndex = 0
   @Published var currentConversationIndex2 = 0
   @Published var quizView: String = "Quiz"
   @Published var quizView2: String = "Quiz"
   @Published var toneView: String = "Quiz"
   @Published var convView: String = "Quiz"
   @Published var recall: String = "Home"
   @Published var showChoice: Bool = true
   
   init() {
      loadChat()
//      print(chat_example)
//      print(stories)
   }
   
   func onTapDetectionChat(_ location: CGPoint, _ midPoint: CGFloat, _ currentIndex: inout Int){
      if location.x < midPoint {
         // Tapped left screen, move to previous item
         if currentIndex > 0 {
            currentIndex -= 1
         }
      } else {
         // Tapped right screen, move to next item
         if currentIndex < chat_example.count - 1 {
            currentIndex += 1
         }
      }
   }
   
   func loadChat(){
      guard let url = Bundle.main.url(forResource: "Chat1_1", withExtension: "json") else {
         print("File not found")
         return
      }
      
      do {
         // Load and decode the JSON data
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         self.chat_example = try decoder.decode([Chat_Example].self, from: data)
      } catch {
         print("Failed to decode JSON: \(error.localizedDescription)")
      }
   }
}
