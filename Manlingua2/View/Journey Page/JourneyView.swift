//
//  JourneyView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct JourneyView: View {
   @StateObject var viewModel = StoryViewModel()
   @EnvironmentObject var router: Router
   
   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         VStack(alignment: .leading) {
            Text("Go to Chinese Hotpot Restaurant")
               .fontWeight(.bold)
               .font(.system(size: 28))
               .foregroundStyle(.white)
               .padding(.top, 2)
            HStack {
               DictionaryButtonView()
                  .padding(.top, 2)
            }
         }
         .padding()
         
         ZStack {
            Rectangle()
               .foregroundStyle(Color(.white))
               .clipShape(.rect(cornerRadius: 32))
               .frame(maxHeight: .infinity)
            
            ZStack {
               // List of Chapters
               ScrollView(.vertical, showsIndicators: false) {
                  VStack(spacing: 24) {
                     //TODO: ChapterCardnya di ForEach in aja nanti
                     ChapterCardView(
                        imageName: "SchoolChapter",
                        chapterNumber: 1,
                        chapterTitle: "At the School",
                        options: ["Vocabulary", "Quiz", "Conversation"],
                        selectedOption: 0,
                        isInactive: .constant(false),
                        isFinished: .constant(true)
                     )
                     
                     ChapterCardView(
                        imageName: "HaidilaoChapter",
                        chapterNumber: 2,
                        chapterTitle: "Arrive at Haidilao",
                        options: ["Vocabulary", "Quiz", "Conversation"],
                        selectedOption: 0,
                        isInactive: .constant(true),
                        isFinished: .constant(false)
                     )
                     
                     ChapterCardView(
                        imageName: "OrderChapter",
                        chapterNumber: 3,
                        chapterTitle: "Ready to Order",
                        options: ["Vocabulary", "Quiz", "Conversation"],
                        selectedOption: 0,
                        isInactive: .constant(true),
                        isFinished: .constant(false)
                     )
                     
                     ChapterCardView(
                        imageName: "SecretCodeChapter",
                        chapterNumber: 4,
                        chapterTitle: "Secret Code",
                        options: ["Vocabulary", "Quiz", "Conversation"],
                        selectedOption: 0,
                        isInactive: .constant(true),
                        isFinished: .constant(false)
                     )
                  }
               }
            }
            .padding(.horizontal, 16)
            .padding(.top, 36)
         }
         
      }
      .edgesIgnoringSafeArea(.bottom)
      .background(
         Image(.homeBackground)
            .ignoresSafeArea()
      )
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            HStack(alignment: .top) {
               Button(action: {
                  router.pop()
               }) {
                  Image(systemName: "chevron.left")
                     .foregroundColor(.white)
                     .font(.title3)
                     .bold()
                  
                  Text("Kembali")
                     .foregroundColor(.white)
                     .bold()
               }
            }
            
//            .padding(.leading)
         }
      }
   }
}

#Preview {
   NavigationStack {
      JourneyView()
         .environmentObject(Router())
   }
}
