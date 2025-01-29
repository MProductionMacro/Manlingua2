//
//  LearnViewModel.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI
import Combine

class LearnViewModel: ObservableObject {
   
   private let pinyinNada = ["ā", "á", "ǎ", "à"]
   private let pinyinInisial = [
      ["b", "p", "m", "f"],
      ["d", "t", "n", "l"],
      ["g", "k", "h"],
      ["j", "q", "x"],
      ["z", "c", "s"],
      ["zh", "ch", "sh", "r"]
   ]
   private let pinyinFinals = [
      ["a", "o", "e", "i", "u", "ü"],
      ["ai", "ei", "ui", "ao", "ou", "iu", "ie", "üe", "an", "en", "in", "un"],
      ["ün", "er"],
      ["ang", "eng", "ing", "ong"]
   ]
   
   init() {
      //loadLearnData()
      //        print(learnData)
   }
   
    public func getPinyinFinals()->[[String]]{
        return self.pinyinFinals
    }
    
    public func getPinyinInisial()->[[String]]{
        return self.pinyinInisial
    }
    
    public func getPinyinNada()->[String]{
        return self.pinyinNada
    }
   
}

