import SwiftData
import SwiftUI

@Model
class Story_Progress {
   public var chapter1: Int
   public var chapter2: Int
   public var chapter3: Int
   public var chapter4: Int
   public var latestStory: Int
   public var latestSubChapter: Int
   public var hasOpenFlashcard: Bool
   public var hasOpenStoryDetail: Bool
   
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
