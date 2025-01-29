//
//  JourneyViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import SwiftUI

class JourneyViewModel: ObservableObject{
   @Published public var story: Story?
   
   @ObservedObject private var swiftData = SwiftDataServices.shared
  
    public func loadStoryData(storyId:Int) {
        // Ganti "StoryData" dengan nama file JSON Anda tanpa ekstensi
        guard let url = Bundle.main.url(forResource: "Story\(storyId)_\(swiftData.getLanguage().rawValue)", withExtension: "json") else {
            print("File StoryData.json tidak ditemukan.")
            return
        }
        
        do {
            // Ambil data dari file JSON
            let data = try Data(contentsOf: url)
            
            // Dekode data JSON ke model Story_Example
            let decoder = JSONDecoder()
            let story = try decoder.decode(Story.self, from: data)
            
            // Assign ke @Published var story
            self.story = story
            //print(story)
            print("Berhasil")
            
        } catch {
            print("Gagal memuat atau mendekode JSON: \(error)")
        }
    }
   
   public func isSubChapterLocked(storyId: Int, subChapter: SubChapter) -> Bool{
      if storyId < swiftData.latestStory {
         return false
      }else if subChapter.id <= swiftData.storyProgress[storyId - 1] {
         return false
      }
      else {
         return true
      }
   }
}
