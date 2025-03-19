//
//  JourneyViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import SwiftUI

class JourneyViewModel: ObservableObject{
   @Published var story: Story_Example?
   
   @ObservedObject var singleton = SwiftDataServices.shared
    @ObservedObject private var swiftData = SwiftDataServices.shared

    func loadStoryData(storyId:Int) {
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
            let story = try decoder.decode(Story_Example.self, from: data)
            
            // Assign ke @Published var story
            self.story = story
            //print(story)
            print("Berhasil")
            
        } catch {
            print("Gagal memuat atau mendekode JSON: \(error)")
        }
    }
   
   func isSubChapterLocked(storyId: Int, subChapter: SubChapter_Example) -> Bool{
      if storyId < singleton.latestStory {
         return false
      }else if subChapter.id <= singleton.storyProgress[storyId - 1] {
         return false
      }
      else {
         return true
      }
   }
}
