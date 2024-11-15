//
//  CoreDataSingleton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 05/11/24.
//

import CoreData
import SwiftUI

class CoreDataSingleton: ObservableObject {
   static let shared = CoreDataSingleton()
   
   @Published var latestStory: Int = 0
   @Published var latestSubChapter: Int = 0
   @Published var storyProgress: [Int] = [1, 1, 1, 1]
   @Published var hasOpenFlashcard: Bool = false
   @Published var hasOpenStoryDetail: Bool = false
   
   private var context: NSManagedObjectContext
   
   private init() {
      context = PersistenceController.shared.container.viewContext
      fetchProgressData()
      
      setLatestChapter()
      setLatestSubChapter()
      setAllSpecificStoryProgress()
   }
   
   // MARK: - CoreData Setup and Fetch
   private func fetchProgressData() {
      let fetchRequest: NSFetchRequest<StoryProgress> = StoryProgress.fetchRequest()
      
      do {
         let results = try context.fetch(fetchRequest)
         if let progressData = results.first {
            // Initialize variables from CoreData attributes
            latestStory = Int(progressData.latestStory)
            latestSubChapter = Int(progressData.latestSubchapter)
            storyProgress = [Int(progressData.chapter1), Int(progressData.chapter2), Int(progressData.chapter3), Int(progressData.chapter4)]
            hasOpenFlashcard = progressData.hasOpenFlashcard
            hasOpenStoryDetail = progressData.hasOpenStoryDetail
         } else {
            initializeDefaultData()
         }
      } catch {
         print("Error fetching data: \(error)")
         initializeDefaultData()
      }
   }
   
   private func initializeDefaultData() {
      latestStory = 1
      latestSubChapter = 1
      storyProgress = [1, 1, 1, 1]
      hasOpenFlashcard = false
      hasOpenStoryDetail = false
      
      saveProgressData()
   }
   
   private func saveProgressData() {
      let fetchRequest: NSFetchRequest<StoryProgress> = StoryProgress.fetchRequest()
      
      do {
         let results = try context.fetch(fetchRequest)
         let progressData = results.first ?? StoryProgress(context: context)
         
         // Set values to CoreData attributes
         progressData.latestStory = Int16(latestStory)
         progressData.latestSubchapter = Int16(latestSubChapter)
         progressData.chapter1 = Int16(storyProgress[0])
         progressData.chapter2 = Int16(storyProgress[1])
         progressData.chapter3 = Int16(storyProgress[2])
         progressData.chapter4 = Int16(storyProgress[3])
         progressData.hasOpenFlashcard = hasOpenFlashcard
         progressData.hasOpenStoryDetail = hasOpenStoryDetail
         
         try context.save()
      } catch {
         print("Error saving data: \(error)")
      }
   }
   
   // MARK: - Functions
   
   func setLatestChapter() {
      latestStory = latestStory == 0 ? 1 : latestStory
      saveProgressData()
   }
   
   func setLatestSubChapter() {
      latestSubChapter = latestSubChapter == 0 ? 1 : latestSubChapter
      saveProgressData()
   }
   
   func updateLatestSubChapter(for subChapterId: Int) {
      if latestSubChapter > 3 {
         updateLatestStory(for: latestStory + 1)
         latestSubChapter = 1
      }else{
         latestSubChapter = subChapterId
      }
      
      saveProgressData()
   }
   
   func updateLatestStory(for chapterId: Int) {
      latestStory = chapterId
      saveProgressData()
   }
   
   func setAllSpecificStoryProgress() {
      for (index, progress) in storyProgress.enumerated() {
         if progress == 0 {
            storyProgress[index] = 1
         }
      }
      saveProgressData()
   }
   
   func getSpecificStoryProgress(storyId: Int) -> Int {
      return storyProgress[storyId - 1]
   }
   
   func updateSpecificStoryProgress(story: Int, subChapterProgress: Int) {
      if subChapterProgress >= storyProgress[story - 1] {
         storyProgress[story - 1] = subChapterProgress
         saveProgressData()
      }
   }
   
   func hasNotOpenFlashcardPage() -> Bool {
      if !hasOpenFlashcard {
         hasOpenFlashcard = true
         saveProgressData()
         return true
      }
      return false
   }
   
   func hasOpenStoryDetailPage() -> Bool {
      if !hasOpenStoryDetail {
         hasOpenStoryDetail = true
         saveProgressData()
         return true
      }
      return false
   }
}
