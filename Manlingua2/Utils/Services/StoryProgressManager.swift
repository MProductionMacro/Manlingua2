//
//  StoryProgressManager.swift
//  Manlingua2
//
//  Created by Paulus Michael on 18/10/24.
//

import SwiftUI

struct StoryProgressManager {
   static func unlockFirstChapterIfNeeded() {
      let hasLaunchedBefore = UserDefaults.standard.bool(forKey: UserDefaultsKey.hasLaunchedBefore.rawValue)
      
      if !hasLaunchedBefore {
         UserDefaults.standard.set(1, forKey: UserDefaultsKey.currentChapter.rawValue)
         UserDefaults.standard.set(1, forKey:"\(UserDefaultsKey.currentSubChapter.rawValue)_1")
         UserDefaults.standard.set(true, forKey: UserDefaultsKey.hasLaunchedBefore.rawValue)
      }
   }
   
   static func setCurrentChapter(for chapterId: Int) {
      UserDefaults.standard.set(chapterId, forKey: UserDefaultsKey.currentChapter.rawValue)
   }
   
   static func getCurrentChapter() -> Int {
      let chapterId = UserDefaults.standard.integer(forKey: UserDefaultsKey.currentChapter.rawValue)
      return chapterId
   }
   
   static func setCurrentSubChapter(for chapterId: Int, subChapterId: Int) {
      UserDefaults.standard.set(subChapterId, forKey: "\(UserDefaultsKey.currentSubChapter.rawValue)_\(chapterId)")
   }
   
   static func getCurrentSubChapter(for chapterId: Int) -> Int? {
      let subChapterId = UserDefaults.standard.integer(forKey: "\(UserDefaultsKey.currentSubChapter.rawValue)_\(chapterId)")
      return subChapterId > 0 ? subChapterId : nil
   }
   
   static func hasNotOpenFlashcardPage() -> Bool {
      if UserDefaults.standard.bool(forKey: "hasOpenFlashcardPage") == false{
         UserDefaults.standard.set(true, forKey: "hasOpenFlashcardPage")
         return true
      }
      else{
         return false
      }
   }
   
   static func hasOpenStoryDetailPage() -> Bool {
      if UserDefaults.standard.bool(forKey: "hasOpenStoryDetailPage") == false{
         UserDefaults.standard.set(true, forKey: "hasOpenStoryDetailPage")
         return true
      }
      else{
         return false
      }
   }
}

enum UserDefaultsKey: String {
   case hasLaunchedBefore
   case currentChapter
   case currentSubChapter
}
