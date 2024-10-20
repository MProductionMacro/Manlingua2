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
               HStack {
                  RectangleButton(labelImage: .diceFive, label: "List Kata-Kata",backgroundColor: .gold2 ,buttonSize: .small,fontSytle: Font.subJudul()){
                     router.push(.dictionary(judul: story.title, storyId: story.id, showFavoriteVocab: false))
                  }
                  //.padding(.top, 2)
               }
            }
            .padding()
            
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
                        
                        
                        // Mengganti warna sesuai kebutuhan
                        //.frame(width: 340)
                        //.padding(.horizontal, 15)
                        
                        HStack{
                           Text("Sub-bab")
                              .font(Font.judulBiasa())
                           Spacer()
                        }
                        .padding(.horizontal, 16)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                           VStack(spacing: 24) {
                              ForEach(story.subChapter, id: \.self){ subChapter in
                                 if let progress = StoryProgressManager.getCurrentSubChapter(for: story.id){
                                    SubChapterCard(labelImage: .schoolChapter, chapter: "Bagian \(subChapter.id)", title: "\(subChapter.title)", pinyin: "\(subChapter.pinyin)", hanzi: "\(subChapter.hanzi)" ,isLocked: subChapter.id <= progress ? false : true, id: story.id)
                                       .padding(.horizontal)
                                 }
                                 
//                                 if subChapter.id <= 2{
//                                    SubChapterCard(labelImage: .schoolChapter, chapter: "Bagian \(subChapter.id)", title: "\(subChapter.title)", pinyin: "\(subChapter.pinyin)", hanzi: "\(subChapter.hanzi)" ,isLocked: false).padding(.horizontal)
//                                 }
//                                 else{
//                                    SubChapterCard(labelImage: .lockChapter, chapter: "Bagian \(subChapter.id)", title: "\(subChapter.title)", pinyin: "\(subChapter.pinyin)", hanzi: "\(subChapter.hanzi)" ,isLocked: true)
//                                       .padding(.horizontal)
//                                 }
                              }
                           }
                           .padding(.top, 5)
                        }
                        
                     }
                     .padding(.bottom, 15)
                  }
               }
               //.padding(.top, 25)
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
   }
}
