//
//  JourneyPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 19/10/24.
//

import SwiftUI

struct JourneyPageView: View {
   @EnvironmentObject var router: Router
   @StateObject var viewModel = JourneyViewModel()
   var storyId:Int
   
   init(storyId: Int){
      self.storyId = storyId
   }
   
   var body: some View {
      VStack(alignment: .leading, spacing: 0) {
         if let story = viewModel.story {
            VStack(alignment: .leading, spacing: 16) {
               VStack(alignment: .leading) {
                  Text("\(story.title)")
                     .font(Font.titleKe2())
                     .foregroundStyle(.white)
                     .padding(.top, 2)
                  Text("\(story.pinyin)")
                     .font(Font.normalText())
                     .foregroundStyle(.white)
                  Text("\(story.hanzi)")
                     .font(Font.judulBiasa())
                     .foregroundStyle(.white)
               }
               
               Button {
                  router.push(.dictionary(judul: story.title, storyId: story.id, showFavoriteVocab: false))
               } label: {
                  HStack {
                     Image(.bookOpenText)
                     Text("List Kata-Kata")
                        .font(.button())
                        .foregroundStyle(.orange3)
                  }
               }
               .buttonStyle(JourneyPageButton())
               
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            // List of Chapters
            
            ZStack {
               CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight])
                  .fill(.white)
                  .edgesIgnoringSafeArea(.bottom)
               
               ScrollView(.vertical, showsIndicators: false) {
                  VStack(alignment: .leading, spacing: 12) {
                     Text("Pengantar")
                        .font(Font.judulBiasa())
                     
                     Text(story.description)
                        .font(.normalText())
                        .padding()
                        .overlay(
                           RoundedRectangle(cornerRadius: 20)
                              .stroke(.customLightGray, lineWidth: 1)
                        )
                     
                     Text("Sub-bab")
                        .font(Font.judulBiasa())
                     
                     VStack(spacing: 24) {
                        ForEach(story.subChapter, id: \.self){ subChapter in
                           if let progress = StoryProgressManager.getCurrentSubChapter(for: story.id){
                              SubChapterCard(labelImage: .schoolChapter, chapter: "Bagian \(subChapter.id)", title: "\(subChapter.title)", pinyin: "\(subChapter.pinyin)", hanzi: "\(subChapter.hanzi)" ,isLocked: subChapter.id <= progress ? false : true, id: story.id, subChapter: subChapter)
                           }
                        }
                     }
                  }
               }
               .padding(.horizontal)
               .padding(.top, 20)
            }
         }
      }
      .onAppear{
         viewModel.loadStoryData(storyId: storyId)
      }
      .background(
         Image(.homeBackground)
            .ignoresSafeArea()
      )
      .toolbar {
         ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
               router.pop()
            }) {
               HStack(spacing: 12) {
                  Image(systemName: "chevron.left")
                     .foregroundStyle(Color.white)
                     .font(Font.button())
                  
                  Text("Kembali")
                     .foregroundStyle(Color.white)
                     .font(Font.button())
               }
            }
            .padding(8)
         }
      }
   }
}

#Preview {
   NavigationView{
      JourneyPageView(storyId: 1)
   }
}
