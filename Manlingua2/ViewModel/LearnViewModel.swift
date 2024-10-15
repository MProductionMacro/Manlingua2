//
//  LearnViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI
import Combine

class LearnViewModel: ObservableObject {
    @Published var learnData: Learn?
    @Published var pinyinInit: [PinyinInit] = []
    @Published var pinyinFinal: [PinyinFinal] = []
    @Published var tones: [Tone] = []
    @Published var currentStage: pinyinCase = .front
   
    let pinyinNada = ["ā", "á", "ǎ", "à"]
    let pinyinInisial = [
        ["b", "p", "m", "f"],
        ["d", "t", "n", "l"],
        ["g", "k", "h"],
        ["j", "q", "x"],
        ["z", "c", "s"],
        ["zh", "ch", "sh", "r"]
    ]
    let pinyinFinalTunggal = [
        ["a", "o", "e", "i"],
        ["u", "ü"]
    ]
    let pinyinFinalGanda = [
        ["ai", "ao", "an", "ang"],
        ["ou", "ong"],
        ["ei", "en", "eng", "er"],
        ["ab", "cd", "ef", "gh"]
    ]
    
    init() {
        loadLearnData()
        print(learnData)
    }
   
    enum pinyinCase {
        case front
        case initial
        case final
        case tone
    }
   
    // Function to load the Learn data from the JSON file
    private func loadLearnData() {
        // Locate the JSON file in the bundle
        guard let url = Bundle.main.url(forResource: "pinyin", withExtension: "json") else {
//         print("File not found")
            return
        }
      
        do {
            // Load and decode the JSON data
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let learn = try decoder.decode(Learn.self, from: data)
            self.learnData = learn
            self.pinyinInit = learn.pinyinInit
            self.pinyinFinal = learn.pinyinFinal
            self.tones = learn.tone
        } catch {
            print("Failed to decode JSON: \(error.localizedDescription)")
        }
    }
}
