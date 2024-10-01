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
            //               Spacer()
         }
         .padding(.leading)
         
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
//         .frame(height: geometry.size.height * 0.30)
         
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
                        selectedOption: 0, // Selected option for Vocabulary,
                        isInactive: .constant(false),
                        isFinished: .constant(true)
                     )
                     
                     ChapterCardView(
                        imageName: "HaidilaoChapter",
                        chapterNumber: 2,
                        chapterTitle: "Arrive at Haidilao",
                        options: ["Vocabulary", "Quiz", "Conversation"],
                        selectedOption: 0, // Selected option for Vocabulary,
                        isInactive: .constant(true),
                        isFinished: .constant(false)
                     )
                     
                     ChapterCardView(
                        imageName: "OrderChapter",
                        chapterNumber: 3,
                        chapterTitle: "Ready to Order",
                        options: ["Vocabulary", "Quiz", "Conversation"],
                        selectedOption: 0, // Selected option for Vocabulary,
                        isInactive: .constant(true),
                        isFinished: .constant(false)
                     )
                     
                     ChapterCardView(
                        imageName: "SecretCodeChapter",
                        chapterNumber: 4,
                        chapterTitle: "Secret Code",
                        options: ["Vocabulary", "Quiz", "Conversation"],
                        selectedOption: 0, // Selected option for Vocabulary,
                        isInactive: .constant(true),
                        isFinished: .constant(false)
                     )
                  }
                  
//                  .frame(minHeight: geometry.size.height * 0.7)
               }
            }
            .padding(.horizontal, 16)
            .padding(.top, 36)
            .padding(.bottom, 56)
//            .frame(height: geometry.size.height * 0.78)
         }
         
      }
      .background(Image(.homeBackground))
   }
}

#Preview {
   JourneyView()
      .environmentObject(Router())
}
