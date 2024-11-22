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
   @Published var chat_preview: [Chat_Example] = []
   @Published var currentSubChapter: SubChapter_Example? = nil
   @Published var currentIndex: Int = 0
   @Published var error: String = ""
   @Published var chapterId: Int = 0
   @ObservedObject var singleton = SwiftDataServices.shared
   @Published var restartStory = [1, 1, 1, 1]
   
   init(){
      loadChatPreview()
   }
   
   func correctAction(modalAppeared: inout Bool, hasAnswered: inout Bool){
      withAnimation{
         //         DispatchQueue.main.async {
         modalAppeared = false
         currentIndex += 1
         hasAnswered = false
         //         }
      }
   }
   
   func wrongAction(modalAppeared: inout Bool, hasAnswered: inout Bool){
      withAnimation{
         //         DispatchQueue.main.async {
         modalAppeared = false
         currentIndex -= 1
         hasAnswered = false
         //         }
      }
   }
   
   func onTapDetectionChat(_ location: CGPoint, _ midPoint: CGFloat, action: () -> Void){
      if location.x < midPoint {
         // Tapped left screen, move to previous item
         if currentIndex > 0 {
            currentIndex -= 1
         }
      } else {
         // Tapped right screen, move to next item
         if currentIndex < chat_example.count - 1 {
            currentIndex += 1
         }else if currentIndex + 1 == chat_example.count {
            action()
         }
      }
   }
   
   func loadChat(storyId: Int, subChapterId: Int){
      let languageCode = UserDefaultSingleton.shared.language
      
      guard let url = Bundle.main.url(forResource: "Chat\(storyId)_\(subChapterId)_\(languageCode)", withExtension: "json") else {
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
   
   func loadChatPreview(){
      guard let url = Bundle.main.url(forResource: "Chat1_1", withExtension: "json") else {
         print("File not found")
         return
      }
      
      do {
         // Load and decode the JSON data
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         self.chat_preview = try decoder.decode([Chat_Example].self, from: data)
      } catch {
         print("Failed to decode JSON: \(error.localizedDescription)")
      }
   }
   
   func updateUserProgress(currentStory: Int, currentSubChapter: Int){
      if currentSubChapter > 3 {
         singleton.updateSpecificStoryProgress(story: currentStory + 1, subChapterProgress: 1)
         restartStory[currentStory - 1] = 1
      }else{
         singleton.updateSpecificStoryProgress(story: currentStory, subChapterProgress: currentSubChapter + 1)
      }
      
      if currentStory == singleton.latestStory && currentSubChapter == singleton.latestSubChapter{
         if currentSubChapter >= 3 {
            singleton.updateLatestSubChapter(for: 1)
            singleton.updateLatestStory(for: currentStory + 1)
         }else{
            singleton.updateLatestSubChapter(for: currentSubChapter + 1)
         }
      }
   }
}
