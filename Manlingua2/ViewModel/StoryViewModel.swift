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
   @Published public var chats: [Chat] = []
   @Published public var chat_preview: [Chat] = []
   @Published public var currentSubChapter: SubChapter? = nil
   @Published public var currentIndex: Int = 0
   @Published public var error: String = ""
   @Published public var chapterId: Int = 0
   @ObservedObject private var swiftData = SwiftDataServices.shared
   @Published public var restartStory = [1, 1, 1, 1]
   @Published public var isRestart = false
   
   init(){
      loadChatPreview()
   }
    
   public func saveDailyProgress(){
        let now = Date()
        let calendar = Calendar.current
        let defaults = UserDefaults.standard
        
        // Retrieve last completion date or handle first launch
        if let lastDate = defaults.object(forKey: "lastCompletionDate") as? Date {
           // Not the first launch
           if !calendar.isDate(lastDate, inSameDayAs: now) {
              if let yesterday = calendar.date(byAdding: .day, value: -1, to: now),
                 calendar.isDate(lastDate, inSameDayAs: yesterday) {
                 // Last task was completed yesterday, increment streak
                  SwiftDataServices.shared.streak += 1
              } else {
                 // Streak broken, reset to 1
                  SwiftDataServices.shared.streak = 0
              }
              
              // Update last completion date
              defaults.set(now, forKey: "lastCompletionDate")
           }
        } else {
           // First launch: initialize streak and save the current date
            SwiftDataServices.shared.streak += 1
           defaults.set(now, forKey: "lastCompletionDate")
        }
        
        // Update task completion and total progress
        if SwiftDataServices.shared.tasks[0] < 1 {
            SwiftDataServices.shared.tasks[0] += 1
            SwiftDataServices.shared.totalTasks = Double(SwiftDataServices.shared.tasks.reduce(0, +)) / Double(SwiftDataServices.shared.tasks.count)
        }
        
        // Save updated progress
        SwiftDataServices.shared.saveGoalProgressData()
    }
   
    public func correctAction(modalAppeared: inout Bool, hasAnswered: inout Bool){
      withAnimation{
         //         DispatchQueue.main.async {
         modalAppeared = false
         currentIndex += 1
         hasAnswered = false
         //         }
      }
   }
   
   public func wrongAction(modalAppeared: inout Bool, hasAnswered: inout Bool){
      withAnimation{
         //         DispatchQueue.main.async {
         modalAppeared = false
         currentIndex -= 1
         hasAnswered = false
         //         }
      }
   }
   
   public func tryAgainAction(modalAppeared: inout Bool, hasAnswered: inout Bool){
       withAnimation{
          //         DispatchQueue.main.async {
          //modalAppeared = false
          modalAppeared = true
          //currentIndex -= 1
          hasAnswered = false
          //         }
       }
    }
    
   public func onTapDetectionChat(_ location: CGPoint, _ midPoint: CGFloat, action: () -> Void){
      if location.x < midPoint {
         // Tapped left screen, move to previous item
         if currentIndex > 0 {
            currentIndex -= 1
         }
      } else {
         // Tapped right screen, move to next item
         if currentIndex < chats.count - 1 {
            currentIndex += 1
         }else if currentIndex + 1 == chats.count {
            action()
         }
      }
   }
   
   public func loadChat(storyId: Int, subChapterId: Int){
       let languageCode = swiftData.getLanguage().rawValue
      
      guard let url = Bundle.main.url(forResource: "Chat\(storyId)_\(subChapterId)_\(languageCode)", withExtension: "json") else {
         print("File not found")
         return
      }
      
      do {
         // Load and decode the JSON data
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         self.chats = try decoder.decode([Chat].self, from: data)
      } catch {
         print("Failed to decode JSON: \(error.localizedDescription)")
      }
   }
   
   public func loadChatPreview(){
      guard let url = Bundle.main.url(forResource: "Chat1_1", withExtension: "json") else {
         print("File not found")
         return
      }
      
      do {
         // Load and decode the JSON data
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         self.chat_preview = try decoder.decode([Chat].self, from: data)
      } catch {
         print("Failed to decode JSON: \(error.localizedDescription)")
      }
   }
   
   public func currentUserProgress(currentStory: Int, currentSubChapter: Int){
       if currentStory < swiftData.latestStory{
           swiftData.updateStoryProgress(story: currentStory, subChapterProgress: currentSubChapter)
       }
   }
   /*
   public func updateUserProgress(currentStory: Int, currentSubChapter: Int){
       //swiftData.updateSpecificStoryProgress(story: currentStory, subChapterProgress: currentSubChapter)
      
       
       //Ini juga kalau seandainya dipanggil berarti story berikutnya bisa kereset dong
      if currentSubChapter > 3 {
         swiftData.updateSpecificStoryProgress(story: currentStory + 1, subChapterProgress: 1)
         restartStory[currentStory - 1] = 1
      }else{
         swiftData.updateSpecificStoryProgress(story: currentStory, subChapterProgress: currentSubChapter + 1)
      }
      
      if currentStory == swiftData.latestStory && currentSubChapter == swiftData.latestSubChapter{
         if currentSubChapter >= 3 {
            swiftData.updateLatestSubChapter(for: 1)
            swiftData.updateLatestStory(for: currentStory + 1)
         }else{
            swiftData.updateLatestSubChapter(for: currentSubChapter + 1)
         }
      }
   }
    */
    public func updateUserProgress(currentStory: Int, currentSubChapter: Int){
        //swiftData.updateSpecificStoryProgress(story: currentStory, subChapterProgress: currentSubChapter)
       
        
        //Ini juga kalau seandainya dipanggil berarti story berikutnya bisa kereset dong
       
       //print("Update User Progress")
       if currentStory == swiftData.latestStory && currentSubChapter == swiftData.latestSubChapter{
          if currentSubChapter == 3 {
              //print("IF ATAS")
             swiftData.updateLatestSubChapter(for: 1)
             swiftData.updateLatestStory(for: currentStory + 1)
          }else{
              //print("ELSE BAWAH")
             swiftData.updateLatestSubChapter(for: currentSubChapter + 1)
          }
       }
        
       
        if currentSubChapter == 3 {
            //swiftData.updateSpecificStoryProgress(story: currentStory, subChapterProgress: 1)
            swiftData.updateStoryProgress(story: currentStory, subChapterProgress: 1)
            //restartStory[currentStory - 1] = 1
        }else{
            swiftData.updateSpecificStoryProgress(story: currentStory, subChapterProgress: currentSubChapter + 1)
        }
       
        
        
    }
}

