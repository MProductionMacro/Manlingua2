//
//  StoryProgressManager.swift
//  Manlingua2
//
//  Created by Paulus Michael on 18/10/24.
//

import SwiftUI

struct StoryProgressManager {
   //   static func unlockFirstChapterIfNeeded() {
   //      let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
   //
   //      if !hasLaunchedBefore {
   //         unlockChapter(chapterId: 1)
   //         UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
   //      }
   //   }
   //
   //   static func isChapterUnlocked(chapterId: Int) -> Bool {
   //      // Fetch the progress from UserDefaults
   //      return UserDefaults.standard.bool(forKey: "chapterUnlocked_\(chapterId)")
   //   }
   //
   //   static func unlockChapter(chapterId: Int) {
   //      // Save the progress to UserDefaults
   //      UserDefaults.standard.set(true, forKey: "chapterUnlocked_\(chapterId)")
   //   }
   //
   //   static func isSubChapterCompleted(subChapterId: Int) -> Bool {
   //      return UserDefaults.standard.bool(forKey: "subChapterCompleted_\(subChapterId)")
   //   }
   //
   //   static func completeSubChapter(subChapterId: Int) {
   //      UserDefaults.standard.set(true, forKey: "subChapterCompleted_\(subChapterId)")
   //   }
   
   static func unlockFirstChapterIfNeeded() {
      let hasLaunchedBefore = UserDefaults.standard.bool(forKey: UserDefaultsKey.hasLaunchedBefore.rawValue)
      
      if !hasLaunchedBefore {
         UserDefaults.standard.set(1, forKey: UserDefaultsKey.currentChapter.rawValue)
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
}

enum UserDefaultsKey: String {
   case hasLaunchedBefore
   case currentChapter
   case currentSubChapter
}
