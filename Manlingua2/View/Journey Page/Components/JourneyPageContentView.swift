//
//  JourneyPageContentView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 11/11/24.
//

import SwiftUI

struct JourneyPageContentView: View {
   var story: Story_Example
   var storyId: Int
   
   @EnvironmentObject var viewModel: JourneyViewModel
   @EnvironmentObject var storyViewModel: StoryViewModel
   @EnvironmentObject var router: Router
   
   @StateObject var singleton = SwiftDataServices.shared
   
   var body: some View {
      ZStack{
         Color.blankBackground.ignoresSafeArea()
            .clipShape(CustomRoundedRectangle(cornerRadius: 16, corners: [.topLeft, .topRight]))
            .frame(maxHeight: .infinity)
         
         //         ScrollView(.vertical, showsIndicators: false) {
          ScrollView{
              VStack(spacing: 12) {
                  HStack{
                      Text("Pengantar".localized)
                          .font(Font.judulBiasa())
                      
                      Spacer()
                  }
                  .padding(.horizontal)
                  //.padding(.horizontal, 15.5)
                
                  
                  Text(story.description)
                      .font(.normalText())
                      //.frame(width: 340, alignment: .leading)
                      .padding()
                      .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.customLightGray, lineWidth: 1)
                      )
                      .padding(.horizontal)

                  
                  HStack{
                      Text("Sub-bab".localized)
                          .font(Font.judulBiasa())
                      Spacer()
                  }
                  .padding(.horizontal, 16)
                  
                  VStack(spacing: 24) {
                      ForEach(story.subChapter, id: \.self){ subChapter in
                          SubChapterCard(labelImage: .schoolChapter ,isLocked: viewModel.isSubChapterLocked(storyId: storyId, subChapter: subChapter), id: story.id, subChapter: subChapter)
//                              .onTapGesture{
//                                  if !viewModel.isSubChapterLocked(storyId: storyId, subChapter: subChapter) {
//                                      router.push(.loadingPage(screen : .storyPage(chapterId: story.id, subChapterId: subChapter.id)))
//
//                                      //router.push(.loadingPage(chapterId: storyId, subChapterId: subChapter.id))
//                                  }
//                                  
//                              }
                              .padding(.horizontal)
                      }
                  }
                  .padding(.top, 5)
                  .padding(.bottom, 25)
                  
                  
                  Spacer()
                  //            }
              }
          }
         .padding(.top, 20)
      }
   }
}


/*
struct JourneyPageContentView: View {
   var story: Story_Example
   var storyId: Int
   
   @EnvironmentObject var viewModel: JourneyViewModel
   @EnvironmentObject var storyViewModel: StoryViewModel
   @EnvironmentObject var router: Router
   
   @StateObject var singleton = CoreDataSingleton.shared
   
   var body: some View {
      ZStack{
         Color.blankBackground.ignoresSafeArea()
            .clipShape(CustomRoundedRectangle(cornerRadius: 16, corners: [.topLeft, .topRight]))
            .frame(maxHeight: .infinity)
         
         //         ScrollView(.vertical, showsIndicators: false) {
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
            
            VStack(spacing: 24) {
               ForEach(story.subChapter, id: \.self){ subChapter in
                  SubChapterCard(labelImage: .schoolChapter ,isLocked: viewModel.isSubChapterLocked(storyId: storyId, subChapter: subChapter), id: story.id, subChapter: subChapter)
                     .onTapGesture{
                        if !viewModel.isSubChapterLocked(storyId: storyId, subChapter: subChapter) {
                           router.push(.loadingPage(chapterId: storyId, subChapterId: subChapter.id))
                        }
                        
                     }
                     .padding(.horizontal)
               }
            }
            .padding(.top, 5)
            .padding(.bottom, 25)
             
             
             Spacer()
            //            }
         }
         .padding(.top, 20)
      }
   }
}
*/
//#Preview {
//   JourneyPageContentView()
//}
