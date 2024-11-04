//
//  SwiftDataTest.swift
//  Manlingua2
//
//  Created by Paulus Michael on 04/11/24.
//

import SwiftData
import Foundation

@Model
class Story_SwiftData: ObservableObject {
   @Attribute(.unique) var id: Int64
   var number: Int64
   var title: String
   var hanzi: String
   var storyDescription: String  // Renamed from `description`
   var pinyin: String
   @Relationship(deleteRule: .cascade, inverse: \SubChapter_SwiftData.id) var subChapters: [SubChapter_SwiftData]
   var isDone: Bool = false
   
   init(id: Int64, number: Int64, title: String, hanzi: String, storyDescription: String, pinyin: String) {
      self.id = id
      self.number = number
      self.title = title
      self.hanzi = hanzi
      self.storyDescription = storyDescription
      self.pinyin = pinyin
      self.subChapters = []
   }
}

@Model
class SubChapter_SwiftData: ObservableObject {
   @Attribute(.unique) var id: Int64
   var title: String
   var pinyin: String
   var hanzi: String
   var duration: Int64
   var chatJSON: String
   var isDone: Bool = false
   @Relationship(deleteRule: .nullify, inverse: \Story_SwiftData.subChapters) var story: Story_SwiftData?
   
   init(id: Int64, title: String, pinyin: String, hanzi: String, duration: Int64, chatJSON: String) {
      self.id = id
      self.title = title
      self.pinyin = pinyin
      self.hanzi = hanzi
      self.duration = duration
      self.chatJSON = chatJSON
   }
}
