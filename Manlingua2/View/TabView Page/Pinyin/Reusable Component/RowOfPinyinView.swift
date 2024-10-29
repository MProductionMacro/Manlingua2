//
//  RowOfPinyinView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/10/24.
//
import SwiftUI

struct RowOfPinyinView: View {
   var listPinyin: [String]
   @Binding var audioController: AudioController
   
   var body: some View {
      HStack(spacing: 12) {
         ForEach(listPinyin, id: \.self) { pinyin in
            PinyinSoundCardView(text: pinyin, speak: pinyin, audioController: $audioController)
               .frame(width: 80, height: 78.45)
         }
      }
      .padding(.horizontal)
   }
}
