//
//  StoryProgressManager.swift
//  Manlingua2
//
//  Created by Paulus Michael on 18/10/24.
//

import SwiftUI

struct StoryProgressManager {
   static func unlockFirstChapterIfNeeded() {
      let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
      
      if !hasLaunchedBefore {
         unlockChapter(chapterId: 1)
         UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
      }
   }
   
   static func isChapterUnlocked(chapterId: Int) -> Bool {
      // Fetch the progress from UserDefaults
      return UserDefaults.standard.bool(forKey: "chapterUnlocked_\(chapterId)")
   }
   
   static func unlockChapter(chapterId: Int) {
      // Save the progress to UserDefaults
      UserDefaults.standard.set(true, forKey: "chapterUnlocked_\(chapterId)")
   }
   
   static func isSubChapterCompleted(subChapterId: Int) -> Bool {
      return UserDefaults.standard.bool(forKey: "subChapterCompleted_\(subChapterId)")
   }
   
   static func completeSubChapter(subChapterId: Int) {
      UserDefaults.standard.set(true, forKey: "subChapterCompleted_\(subChapterId)")
   }
}
