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
   @StateObject var singleton = CoreDataSingleton.shared
   var storyId:Int
   
   init(storyId: Int){
      self.storyId = storyId
   }
   
   var body: some View {
      VStack(alignment: .center, spacing: 0) {
         if let story = viewModel.story {
            /*
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
                 Button {
                     router.push(.dictionary(judul: story.title, displayMode: .story(id: story.id)))
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
            .padding()
            */
             
             HStack(alignment: .top){
                 VStack(alignment: .leading) {
                      Text("\(story.title)")
                       .font(Font.titleKe2())
                       .foregroundStyle(.white)
                      Text("\(story.pinyin)")
                       .font(Font.normalText())
                       .foregroundStyle(.white)
                      Text("\(story.hanzi)")
                       .font(Font.judulBiasa())
                       .foregroundStyle(.white)
                 }

                 Spacer()
                 
                 Button {
                     router.push(.dictionary(judul: story.title, displayMode: .story(id: story.id)))
                 } label: {
                     HStack(spacing: 8){
                         Image(systemName: "books.vertical")
                             .font(Font.semibold16())
                             .foregroundStyle(.orange3)
                         Text("List Kata-Kata")
                             .font(Font.semibold16())
                             .foregroundStyle(.orange3)
                     }
                     .frame(width: 160, height: 35)
                     .background(Color.gold2)
                     .cornerRadius(8)
                 }
             }
             .padding(.horizontal, 15.5)
             .padding(.vertical)
             
            ZStack {
               Rectangle()
                  .foregroundStyle(.white)
                  .clipShape(.rect(cornerRadius: 32))
                  .frame(maxHeight: .infinity)
               
               ZStack {
                  // List of Chapters
                  ScrollView(.vertical, showsIndicators: false) {
                     VStack(spacing: 12) {
                        HStack{
                           Text("Pengantar")
                              .font(Font.judulBiasa())
                           Spacer()
                        }
                        .padding(.horizontal, 15.5)
                        
                        
                        Text(story.description)
                           .font(.normalText())
                           .frame(width: 340, alignment: .leading)
                           .padding()
                           .overlay(
                              RoundedRectangle(cornerRadius: 20)
                                 .stroke(.customLightGray, lineWidth: 1)
                           )
                        
                        HStack{
                           Text("Sub-bab")
                              .font(Font.judulBiasa())
                           Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                           VStack(spacing: 24) {
                              ForEach(story.subChapter, id: \.self){ subChapter in
                                  SubChapterCard(labelImage: .schoolChapter ,isLocked: viewModel.isSubChapterLocked(storyId: storyId, subChapter: subChapter), id: story.id, subChapter: subChapter)
                                      .onTapGesture{
                                          if !viewModel.isSubChapterLocked(storyId: storyId, subChapter: subChapter) {
                                              singleton.updateSpecificStoryProgress(story: storyId, subChapterProgress: subChapter.id)
                                              router.push(.storyPage(chapterId: storyId, subChapterId: subChapter.id, isFromHome: false))
                                          }
                                          
                                      }
                                     .padding(.horizontal)
                              }
                           }
                           .padding(.top, 5)
                        }
                        
                     }
                     .padding(.bottom, 25)
                  }
               }
               .padding(.top, 20)
            }
         }
      }
      .onAppear{
         viewModel.loadStoryData(storyId: storyId)
      }
      .edgesIgnoringSafeArea(.bottom)
      .background(
         Image(.homeBackground)
            .ignoresSafeArea()
      )
      .toolbar {
         ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
               router.pop()
            }) {
               HStack {
                  Image(systemName: "chevron.left")
                     .foregroundStyle(Color.white)
                     .font(Font.button())
                  
                  Text("Kembali")
                     .foregroundStyle(Color.white)
                     .font(Font.button())
               }
            }
         }
      }
   }
}



#Preview {
   NavigationView{
      JourneyPageView(storyId: 1)
           .environmentObject(Router())
   }
}
