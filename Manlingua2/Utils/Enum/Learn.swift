//
//  Learn.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import Foundation

struct Learn: Codable {
   let pinyinInit: [PinyinInit]
   let pinyinFinal: [PinyinFinal]
   let tone: [Tone]
   
   enum CodingKeys: String, CodingKey {
      case pinyinInit = "pinyininit"
      case pinyinFinal = "pinyinfinal"
      case tone
   }
}

struct PinyinInit: Codable {
   let pinyin: String
   let sound: String
}

struct PinyinFinal: Codable {
   let pinyin: String
   let sound: String
}

struct Tone: Codable {
   let jenis: String
   let desc: String
   let hanzi: String
   let pinyin: String
   let mean: String
   let soundtone: String
}
