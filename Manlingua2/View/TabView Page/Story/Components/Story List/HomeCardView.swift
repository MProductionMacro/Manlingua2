//
//  HomeCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardView: View {
   @State var homeCard: ImageResource
   @State var isComplete: Bool
   
   @Binding var isDisabled: Bool
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var homeVM: HomeViewModel
   @EnvironmentObject var storyVM: StoryViewModel
   @StateObject var singleton = CoreDataSingleton.shared
   
   var story: Story_Example
   
   var body: some View {
      //TODO: Framenya hard coded, takut ga responsive
      VStack(alignment: .center, spacing: 16) {
         Image(.story1Thumbnail)
            .saturation(isDisabled ? 0 : 1)
            .colorMultiply(isDisabled ? .customLighterGray : .white)
         
         VStack(alignment: .leading, spacing: 4) {
            Text("Cerita \(story.id)")
               .font(.pinyin())
               .fontWeight(.bold)
               .foregroundStyle(.black)
            
            Text(story.title)
               .font(.subJudul())
               .foregroundStyle(.black)
            
            VStack(alignment: .leading, spacing: 0){
               Text(story.pinyin)
                  .font(.pinyin())
                  .foregroundStyle(.darkGrey)
               
               Text(story.hanzi)
                  .font(.subJudul())
                  .foregroundStyle(.darkGrey)
            }
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         
         ProgressView(value: Float(singleton.storyProgress[story.id - 1] - 1), total: Float(story.subChapter.count))
            .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
         
         HStack {
            Button {
               if !isDisabled {
                  let subChapterId = singleton.latestSubChapter
//                  router.push(.storyPage(chapterId: story.id, subChapterId: subChapterId))
                  router.push(.loadingPage(chapterId: story.id, subChapterId: subChapterId == 0 ? 1 : subChapterId))
               }
            } label: {
               Text("Mulai")
                  .frame(maxWidth: .infinity)
            }
            .buttonStyle(PrimaryButton(isDisabled: isDisabled))
            .disabled(isDisabled)
            
            //            CardMenuButtonView(isDisabled: isDisabled, storyId: story.id)
            Button {
               router.push(.journeyPage(storyId: story.id))
            } label: {
               Image(systemName: "point.bottomleft.forward.to.point.topright.scurvepath.fill")
            }
            .buttonStyle(SecondaryButton(isDisabled: isDisabled))
            .disabled(isDisabled)
         }
      }
      .padding()
      .background(.white)
      .clipShape(.rect(cornerRadius: 24))
      .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
      .frame(maxHeight: .infinity, alignment: .top)
   }
}

//#Preview {
//   HomeCardView(homeCard: .story1Thumbnail, storyName: "Go to Chinese Hotpot\nRestaurant", isDisabled: false, isComplete: false, story: <#Binding<Story_Example>#>)
//}
