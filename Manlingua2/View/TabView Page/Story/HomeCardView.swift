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
            PrimaryButtonView(isDisabled: isDisabled)
            CardMenuButtonView(isDisabled: isDisabled)
         }
      }
      .padding()
      .background(.white)
      .clipShape(.rect(cornerRadius: 24))
      .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
//      .frame(width: 232)
      .frame(maxHeight: .infinity, alignment: .top)
      .onAppear {
         isDisabled = !StoryProgressManager.isChapterUnlocked(chapterId: story.id)
      }
   }
}

//#Preview {
//   HomeCardView(homeCard: .story1Thumbnail, storyName: "Go to Chinese Hotpot\nRestaurant", isDisabled: false, isComplete: false, story: <#Binding<Story_Example>#>)
//}
