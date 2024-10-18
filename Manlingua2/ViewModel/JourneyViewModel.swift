//
//  JourneyViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 28/09/24.
//

import Foundation

class JourneyViewModel: ObservableObject{
    @Published var story: Story_Example?
    
    func loadStoryData(storyId:Int) {
        // Ganti "StoryData" dengan nama file JSON Anda tanpa ekstensi
        guard let url = Bundle.main.url(forResource: "Story\(storyId)", withExtension: "json") else {
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
            
        } catch {
            print("Gagal memuat atau mendekode JSON: \(error)")
        }
    }

}
