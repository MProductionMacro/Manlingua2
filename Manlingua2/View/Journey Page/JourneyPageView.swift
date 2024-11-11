//
//  JourneyPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 19/10/24.
//

import SwiftUI

struct JourneyPageView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var storyViewModel: StoryViewModel
   @EnvironmentObject var viewModel: JourneyViewModel
   
   @StateObject var singleton = CoreDataSingleton.shared
   
   var storyId:Int
   
   init(storyId: Int){
      self.storyId = storyId
   }
   
   var body: some View {
      VStack(alignment: .center, spacing: 0) {
         if let story = viewModel.story {
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
            
            // List of Chapters
            JourneyPageContentView(story: story, storyId: storyId)
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
         .environmentObject(StoryViewModel())
         .environmentObject(JourneyViewModel())
   }
}
