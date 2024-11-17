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
   
   //MARK: Story Progress
   @Published var latestStory: Int = 0
   @Published var latestSubChapter: Int = 0
   @Published var storyProgress: [Int] = [1, 1, 1, 1]
   @Published var hasOpenFlashcard: Bool = false
   @Published var hasOpenStoryDetail: Bool = false
   
   //MARK: Goal Page Progress
   @Published var task1 = 0
   @Published var task2 = 0
   @Published var task3 = 0
   @Published var totalTasks = 0
   @Published var totalStars = 0
   
   private var context: NSManagedObjectContext
   
   private init() {
      context = PersistenceController.shared.container.viewContext
      fetchStoryProgressData()
      fetchGoalPageProgressData()
      
      setLatestChapter()
      setLatestSubChapter()
      setAllSpecificStoryProgress()
   }
   
   // MARK: - CoreData Setup and Fetch
   private func fetchStoryProgressData() {
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
            initializeStoryDefaultData()
         }
      } catch {
         print("Error fetching data: \(error)")
         initializeStoryDefaultData()
      }
   }
   
   private func fetchGoalPageProgressData() {
      let fetchRequest: NSFetchRequest<GoalPageProgress> = GoalPageProgress.fetchRequest()
      
      do {
         let results = try context.fetch(fetchRequest)
         if let progressData = results.first {
            task1 = Int(progressData.task1)
            task2 = Int(progressData.task2)
            task3 = Int(progressData.task3)
            totalTasks = Int(progressData.totalTasks)
            totalStars = Int(progressData.totalStars)
         }else{
            initializeGoalPageProgressData()
         }
      } catch {
         print("Error fetching data: \(error)")
         initializeGoalPageProgressData()
      }
   }
   
   private func initializeGoalPageProgressData() {
      task1 = 0
      task2 = 0
      task3 = 0
      totalTasks = 0
      totalStars = 0
      
      saveGoalPageProgressData()
   }
   
   private func initializeStoryDefaultData() {
      latestStory = 1
      latestSubChapter = 1
      storyProgress = [1, 1, 1, 1]
      hasOpenFlashcard = false
      hasOpenStoryDetail = false
      
      saveStoryProgressData()
   }
   
   private func saveGoalPageProgressData() {
      let fetchRequest: NSFetchRequest<GoalPageProgress> = GoalPageProgress.fetchRequest()
      
      do {
         let results = try context.fetch(fetchRequest)
         let progressData = results.first ?? GoalPageProgress(context: context)
         
         progressData.task1 = Int16(task1)
         progressData.task2 = Int16(task2)
         progressData.task3 = Int16(task3)
         progressData.totalTasks = Int16(totalTasks)
         progressData.totalStars = Int16(totalStars)
         
         try context.save()
      } catch {
         print("Error saving data: \(error)")
      }
   }
   
   private func saveStoryProgressData() {
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
      saveStoryProgressData()
   }
   
   func setLatestSubChapter() {
      latestSubChapter = latestSubChapter == 0 ? 1 : latestSubChapter
      saveStoryProgressData()
   }
   
   func updateLatestSubChapter(for subChapterId: Int) {
      if latestSubChapter > 3 {
         updateLatestStory(for: latestStory + 1)
         latestSubChapter = 1
      }else{
         latestSubChapter = subChapterId
      }
      
      saveStoryProgressData()
   }
   
   func updateLatestStory(for chapterId: Int) {
      latestStory = chapterId
      saveStoryProgressData()
   }
   
   func setAllSpecificStoryProgress() {
      for (index, progress) in storyProgress.enumerated() {
         if progress == 0 {
            storyProgress[index] = 1
         }
      }
      saveStoryProgressData()
   }
   
   func getSpecificStoryProgress(storyId: Int) -> Int {
      return storyProgress[storyId - 1]
   }
   
   func updateSpecificStoryProgress(story: Int, subChapterProgress: Int) {
      if subChapterProgress >= storyProgress[story - 1] {
         storyProgress[story - 1] = subChapterProgress
         saveStoryProgressData()
      }
   }
   
   func hasNotOpenFlashcardPage() -> Bool {
      if !hasOpenFlashcard {
         hasOpenFlashcard = true
         saveStoryProgressData()
         return true
      }
      return false
   }
   
   func hasOpenStoryDetailPage() -> Bool {
      if !hasOpenStoryDetail {
         hasOpenStoryDetail = true
         saveStoryProgressData()
         return true
      }
      return false
   }
}
