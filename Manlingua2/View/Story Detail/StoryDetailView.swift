//
//  StoryDetailView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct StoryDetailView: View {
   @EnvironmentObject private var viewModel: StoryViewModel
   @EnvironmentObject private var learnVM: LearnViewModel
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var router: Router
   
   @State var hanziArray: [String] = ["您好， 明先生。我们商量价格。", "再见，李小姐。", "明天见！"]
   @State var pinyinArray: [String] = ["nín hǎo, míng xiānshēng. wǒmen shāngliáng jiàgé", "zàijiàn, lǐ xiǎojiě.", "míngtiān jiàn!"]
   
   @State var currentIndex: Int = 0
   @State var hanzi: String = "您好， 明先生。我们商量价格。"
   @State var pinyin: String = "nín hǎo, míng xiānshēng. wǒmen shāngliáng jiàgé"
   
   @State var tutorialOverlay: Int = 1
   
   var body: some View {
      GeometryReader { geometry in
         ZStack {
            VStack(spacing: 24) {
               HStack(spacing: 4) {
                  Button {
                     router.pop()
                  } label: {
                     Image(systemName: "xmark")
                        .font(.system(size: 32))
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.orange3)
                  }
                  
                  Spacer()
                  
                  ProgressView(value: Double(currentIndex + 1) / Double(hanziArray.count))
                     .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
               }
               
               ForEach(0...currentIndex, id: \.self) { index in
                  BubbleChatView(pinyin: .constant(pinyinArray[index]), hanzi: .constant(hanziArray[index]))
                     .padding(.leading, 4)
               }
               
               
               Spacer()
            }
            .padding(.horizontal)
            .background(
               Image(.chatBackground)
                  .scaledToFill()
            )
            .onTapGesture { location in
               let screenWidth = geometry.size.width
               let midPoint = screenWidth / 2
               
               if location.x < midPoint {
                  // Tapped left screen, move to previous item
                  if currentIndex > 0 {
                     currentIndex -= 1
                     hanzi = hanziArray[currentIndex] // Update displayed hanzi
                     pinyin = pinyinArray[currentIndex] // Update displayed pinyin
                  }
               } else {
                  // Tapped right screen, move to next item
                  if currentIndex < hanziArray.count - 1 {
                     currentIndex += 1
                     hanzi = hanziArray[currentIndex] // Update displayed hanzi
                     pinyin = pinyinArray[currentIndex] // Update displayed pinyin
                  }
               }
            }
            
            SidebarButton()
         }
         .overlay {
             TutorialOverlayView(tutorialOverlay: $tutorialOverlay, width: geometry.size.width * 0.7)
         }
      }
   }
}

#Preview {
   StoryDetailView()
      .environmentObject(StoryViewModel())
      .environmentObject(LearnViewModel())
      .environmentObject(HomeViewModel())
      .environmentObject(Router())
}

