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
   @Published var currentSubChapter: SubChapter_Example? = nil
   @Published var currentIndex: Int = 0
   @Published var error: String = ""
   @Published var chapterId: Int = 0
   
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
   
   func loadChatForSubChapter(_ subChapter: SubChapter_Example) {
      self.currentSubChapter = subChapter
      
      guard let url = Bundle.main.url(forResource: subChapter.chat_json, withExtension: "json") else {
         print("File not found")
         return
      }
      
      do {
         // Load and decode the JSON data
         let data = try Data(contentsOf: url)
         let decoder = JSONDecoder()
         self.chat_example = try decoder.decode([Chat_Example].self, from: data)
      } catch {
         fatalError(error.localizedDescription)
      }
      
      StoryProgressManager.setCurrentSubChapter(for: chapterId, subChapterId: subChapter.id)
   }
   
   func oneSubChapterDone(_ chapterId: Int){
      let subChapterId = StoryProgressManager.getCurrentSubChapter(for: chapterId) ?? 0
      
      StoryProgressManager.setCurrentSubChapter(for: chapterId, subChapterId: subChapterId + 1)
   }
   
   func allSubChapterDone(chapterId: Int){
      if let currentSubChap = StoryProgressManager.getCurrentSubChapter(for: chapterId) {
         if currentSubChap >= 4 {
            StoryProgressManager.setCurrentSubChapter(for: chapterId, subChapterId: currentSubChap - 1)
            StoryProgressManager.setCurrentSubChapter(for: chapterId + 1, subChapterId: 1)
            StoryProgressManager.setCurrentChapter(for: chapterId + 1)
         }
      }
   }
   
   func loadProgressForChapter(_ chapterId: Int, subChapters: [SubChapter_Example]) {
      self.chapterId = chapterId
      
      // Check if there's a saved subchapter progress
      if let savedSubChapterId = StoryProgressManager.getCurrentSubChapter(for: chapterId),
         let savedSubChapter = subChapters.first(where: { $0.id == savedSubChapterId }) {
         loadChatForSubChapter(savedSubChapter)
      }
   }
}
