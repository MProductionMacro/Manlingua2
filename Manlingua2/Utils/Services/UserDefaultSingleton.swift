//
//  UserDefaultSingleton.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/10/24.
//

import Foundation
class UserDefaultSingleton : ObservableObject{
    static var shared = UserDefaultSingleton()
    
    @Published var latestStory: Int = 0
    @Published var latestSubChapter: Int = 0
    @Published var storyProgress: [Int] = [1,1,1,1]
    @Published var hasOpenFlashcard: Bool = false
    @Published var hasOpenStoryDetail: Bool = false

    
    private init(){
        setLatestChapter()
        setLatestSubChapter()
        setAllSpecificStoryProgress()
    }
    
    func setLatestChapter() {
        latestStory = UserDefaults.standard.integer(forKey: "LatestChapter")
        if latestStory == 0{
            UserDefaults.standard.set(1, forKey: "LatestChapter")
            latestStory = 1
        }
    }
    
    func setLatestSubChapter(){
        latestSubChapter = UserDefaults.standard.integer(forKey: "LatestSubChapter")
        if latestSubChapter == 0 {
            UserDefaults.standard.set(1, forKey: "LatestSubChapter")
            latestSubChapter = 1
        }
    }
    
    func updateLatestSubChapter(for subChapterId: Int) {
        UserDefaults.standard.set(subChapterId, forKey: "LatestSubChapter")
        latestSubChapter = subChapterId
    }
    
    func updateLatestStory(for chapterId: Int) {
        UserDefaults.standard.set(chapterId, forKey: "LatestChapter")
        latestStory = chapterId
    }
    
    
    func setAllSpecificStoryProgress() {
        for chapter_id in 0..<4 {
            if UserDefaults.standard.integer(forKey: "Chapter_\(chapter_id + 1)") == 0 {
                //updateSpecificStoryProgress(story: story, subChapterProgress: 1)
                UserDefaults.standard.set(1, forKey: "Chapter_\(chapter_id + 1)")
                storyProgress[chapter_id] = 1
            }
            else{
                storyProgress[chapter_id] = UserDefaults.standard.integer(forKey: "Chapter_\(chapter_id + 1)")
            }
        }
    }
    
    func getSpecificStoryProgress(storyId: Int) -> Int {
        return storyProgress[storyId - 1]
    }
    
    
    func updateSpecificStoryProgress(story: Int, subChapterProgress: Int) {
        UserDefaults.standard.set(subChapterProgress, forKey: "Chapter_\(story)")
        storyProgress[story - 1] = subChapterProgress
    }
   
    
    func hasNotOpenFlashcardPage() -> Bool {
        if UserDefaults.standard.bool(forKey: "hasOpenFlashcardPage") == false{
            UserDefaults.standard.set(true, forKey: "hasOpenFlashcardPage")
            return true
        }
        else{
            return false
        }
        
    }
    
    func hasOpenStoryDetailPage() -> Bool {
        if UserDefaults.standard.bool(forKey: "hasOpenStoryDetailPage") == false{
            UserDefaults.standard.set(true, forKey: "hasOpenStoryDetailPage")
            return true
        }
        else{
            return false
        }
    }
    
/*
     func unlockFirstChapterIfNeeded() {
         let hasLaunchedBefore = UserDefaults.standard.bool(forKey: UserDefaultsKey.hasLaunchedBefore.rawValue)
       
         if !hasLaunchedBefore {
             UserDefaults.standard.set(1, forKey: UserDefaultsKey.currentChapter.rawValue)
             UserDefaults.standard.set(true, forKey: UserDefaultsKey.hasLaunchedBefore.rawValue)
         }
     }
 
 
     func setCurrentChapter(for chapterId: Int) {
         UserDefaults.standard.set(chapterId, forKey: UserDefaultsKey.currentChapter.rawValue)
     }

     func getCurrentChapter() -> Int {
         let chapterId = UserDefaults.standard.integer(forKey: UserDefaultsKey.currentChapter.rawValue)
         return chapterId
     }

     func setCurrentSubChapter(for chapterId: Int, subChapterId: Int) {
         UserDefaults.standard.set(subChapterId, forKey: "\(UserDefaultsKey.currentSubChapter.rawValue)_\(chapterId)")
     }

     func getCurrentSubChapter(for chapterId: Int) -> Int? {
         let subChapterId = UserDefaults.standard.integer(forKey: "\(UserDefaultsKey.currentSubChapter.rawValue)_\(chapterId)")
         return subChapterId > 0 ? subChapterId : nil
     }
 */
}


