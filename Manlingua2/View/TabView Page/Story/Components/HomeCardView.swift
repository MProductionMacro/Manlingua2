//
//  HomeCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardView: View {
   @State var homeCard: ImageResource
   @State var isDisabled: Bool
   @State var isComplete: Bool
   @State var subChapterId = 0
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var homeVM: HomeViewModel
   @EnvironmentObject var storyVM: StoryViewModel
   
   var story: Story_Example
   
   var body: some View {
      //TODO: Framenya hard coded, takut ga responsive
      VStack(alignment: .leading, spacing: 16) {
         Image(.story1Thumbnail)
         
         Text("Cerita \(story.id)")
            .font(.subJudul())
            .foregroundStyle(.black)
         
         VStack(alignment: .leading) {
            Text(story.title)
               .font(.judulBiasa())
               .foregroundStyle(.black)
            
            Text(story.pinyin)
               .font(.pinyin())
               .foregroundStyle(.darkGrey)
            
            Text(story.hanzi)
               .font(.subJudul())
               .foregroundStyle(.darkGrey)
         }
         
         HStack {
//            PrimaryButtonView(isDisabled: isDisabled, id: story.id)
            Button {
               storyVM.loadProgressForChapter(story.id, subChapters: homeVM.stories_example[story.id - 1].subChapter)
               router.push(.storyPage(chapterId: story.id, isFromHome: true))
            } label: {
               Text("Mulai")
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
      .onAppear {
         subChapterId = StoryProgressManager.getCurrentSubChapter(for: story.id) ?? 1
      }
   }
}

//#Preview {
//   HomeCardView(homeCard: .story1Thumbnail, storyName: "Go to Chinese Hotpot\nRestaurant", isDisabled: false, isComplete: false, story: <#Binding<Story_Example>#>)
//}
