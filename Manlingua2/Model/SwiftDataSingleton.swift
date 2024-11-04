////
////  SwiftDataSingleton.swift
////  Manlingua2
////
////  Created by Paulus Michael on 04/11/24.
////
//
//import SwiftData
//import Foundation
//
//@MainActor
//class SwiftDataSingleton: ObservableObject {
//   @Environment(\.managedObjectContext) private var context
//   
//   static let shared = SwiftDataSingleton()
//   private init() {}
//   
//   // Fetch all stories
//   func fetchStories() async throws -> [Story_SwiftData] {
//      let request = Story_SwiftData.fetchRequest()
//      return try context.fetch(request)
//   }
//   
//   // Fetch a story by ID
//   func fetchStory(byID id: Int64) async throws -> Story? {
//      let request = Story_SwiftData.fetchRequest()
//      request.predicate = NSPredicate(format: "id == %d", id)
//      return try context.fetch(request).first
//   }
//   
//   // Mark a story as done
//   func markStoryAsDone(storyID: Int64) async {
//      do {
//         if let story = try await fetchStory(byID: storyID) {
//            story.isDone = true
//            try context.save()
//         }
//      } catch {
//         print("Failed to mark story as done: \(error)")
//      }
//   }
//   
//   // Fetch subchapter by ID
//   func fetchSubChapter(byID id: Int64) async throws -> SubChapter? {
//      let request = SubChapter.fetchRequest()
//      request.predicate = NSPredicate(format: "id == %d", id)
//      return try context.fetch(request).first
//   }
//   
//   // Mark a subchapter as done
//   func markSubChapterAsDone(subChapterID: Int64) async {
//      do {
//         if let subChapter = try await fetchSubChapter(byID: subChapterID) {
//            subChapter.isDone = true
//            try context.save()
//         }
//      } catch {
//         print("Failed to mark subchapter as done: \(error)")
//      }
//   }
//   
//   // Reset all progress in stories and subchapters
//   func resetAllProgress() async {
//      do {
//         let stories = try await fetchStories()
//         for story in stories {
//            story.isDone = false
//            for subChapter in story.subChapters {
//               subChapter.isDone = false
//            }
//         }
//         try context.save()
//      } catch {
//         print("Failed to reset all progress: \(error)")
//      }
//   }
//}
