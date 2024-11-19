//
//  StoryProgress.swift
//  Manlingua2
//
//  Created by Paulus Michael on 18/11/24.
//

import SwiftData
import SwiftUI

@Model
class Story_Progress {
   var chapter1: Int
   var chapter2: Int
   var chapter3: Int
   var chapter4: Int
   var latestStory: Int
   var latestSubChapter: Int
   var hasOpenFlashcard: Bool
   var hasOpenStoryDetail: Bool
   
   init(chapter1: Int, chapter2: Int, chapter3: Int, chapter4: Int, latestStory: Int, latestSubChapter: Int, hasOpenFlashcard: Bool, hasOpenStoryDetail: Bool) {
      self.chapter1 = chapter1
      self.chapter2 = chapter2
      self.chapter3 = chapter3
      self.chapter4 = chapter4
      self.latestStory = latestStory
      self.latestSubChapter = latestSubChapter
      self.hasOpenFlashcard = hasOpenFlashcard
      self.hasOpenStoryDetail = hasOpenStoryDetail
   }
}
