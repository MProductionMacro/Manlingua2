//
//  HomeCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardView: View {
   //@State var homeCard: ImageResource
   @State var isComplete: Bool
   
   @Binding var isDisabled: Bool
   
   @EnvironmentObject private var router: Router
   @EnvironmentObject private var homeVM: HomeViewModel
   @EnvironmentObject private var storyVM: StoryViewModel
   @StateObject private var singleton = SwiftDataServices.shared
   
   var story: Story
   
   var body: some View {
      //TODO: Framenya hard coded, takut ga responsive
      VStack(alignment: .center, spacing: 16) {
         if isDisabled {
            Image(.homeLock)
               .resizable()
               .frame(width: 148, height: 148)
         }
         else{
            Image(.homeHaidilao)
               .resizable()
               .frame(width: 148, height: 148)
         }
         
         VStack(alignment: .leading, spacing: 4) {
             Text("Cerita".localized + " \(story.id)".localized)
               .font(.pinyin())
               .fontWeight(.bold)
            
            Text(story.title)
               .font(.subJudul())
            
            VStack(alignment: .leading, spacing: 0){
               Text(story.pinyin)
                  .font(.pinyin())
                  .foregroundStyle(.emptyListText)
               
               Text(story.hanzi)
                  .font(.subJudul())
                  .foregroundStyle(.emptyListText)
            }
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         
          
          
         if story.id < singleton.latestStory{
             ProgressView(value: 3, total: 3)
                .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .greenNormalActive, unfilledColor: .progressBar ))
         }
         else{
             ProgressView(value: Float(singleton.storyProgress[story.id - 1] - 1), total: 3)
                .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .greenNormalActive, unfilledColor: .progressBar ))
         }
         
         HStack {
            Button {
               if !isDisabled {
                  let subChapterId = singleton.latestSubChapter
                  let chapterId = singleton.latestStory
                  
                  /*
                  storyVM.isRestart = story.id < chapterId
                  storyVM.loadChat(storyId: story.id, subChapterId: storyVM.isRestart ? storyVM.restartStory[story.id - 1] : subChapterId)
                   
                   storyVM.currentIndex = 0
                   router.push(.loadingPage(screen : .storyPage(chapterId: story.id, subChapterId: storyVM.isRestart ? storyVM.restartStory[story.id - 1] : subChapterId)))
                   */
                   
                   
                  print("Story Id: \(story.id)")
                  print("Subchapter Id: \(singleton.storyProgress[story.id - 1])")
                  storyVM.loadChat(storyId: story.id, subChapterId: singleton.storyProgress[story.id - 1])
                   
                   
                  storyVM.currentIndex = 0
                  router.push(.loadingPage(screen : .storyPage(chapterId: story.id, subChapterId: singleton.storyProgress[story.id - 1])))
//                  router.push(.donePage(displayMode: .story(storyId: 1, subChapterId: 1), chapterId: 1, subChapterId: 1))
               }
            } label: {
                Text("Mulai".localized)
                  .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButton(isDisabled: isDisabled))
            .disabled(isDisabled)
            
            //            CardMenuButtonView(isDisabled: isDisabled, storyId: story.id)
            Button {
               router.push(.journeyPage(storyId: story.id))
            } label: {
               Image(systemName: "point.bottomleft.forward.to.point.topright.scurvepath.fill")
                    .foregroundStyle(isDisabled ? Color.homeCardLock : Color.orangeDarkMode)
                    .font(.button())
                    .padding(12)
                    .background(.cardBackground)
                    .clipShape(.rect(cornerRadius: 8))
                    .overlay(
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(isDisabled ? Color.homeCardLock : Color.orangeDarkMode, lineWidth: 2)
                    )
            }
            .disabled(isDisabled)
         }
      }
      .padding()
      .background(.cardBackground)
      .clipShape(.rect(cornerRadius: 24))
      .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
      .frame(maxHeight: .infinity, alignment: .top)
   }
}

//#Preview {
//   HomeCardView(homeCard: .story1Thumbnail, storyName: "Go to Chinese Hotpot\nRestaurant", isDisabled: false, isComplete: false, story: <#Binding<Story_Example>#>)
//}
