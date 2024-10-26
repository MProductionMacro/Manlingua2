//
//  RowOfPinyinView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 11/10/24.
//
import SwiftUI

struct RowOfPinyinView: View {
    var listPinyin: [String]
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(listPinyin, id: \.self) { pinyin in
                PinyinSoundCardView2(text: pinyin, speak: pinyin)
                    .frame(width: 80, height: 78.45)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    RowOfPinyinView(listPinyin: ["a", "e", "i", "o", "u"])
}
