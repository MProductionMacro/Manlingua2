//
//  HomeCardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/09/24.
//

import SwiftUI

struct HomeCardView: View {
   @State var homeCard: ImageResource
   @State var storyName: String
   @State var isDisabled: Bool
   @State var isComplete: Bool
   
   var story: Story_Example
   
   var body: some View {
      //TODO: Framenya hard coded, takut ga responsive
      VStack(alignment: .center, spacing: 16) {
         Image(.story1Thumbnail)
         
         Text("Cerita \(story.id)")
            .font(.subJudul())
            .foregroundStyle(.black)
//            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
         
         VStack(alignment: .leading) {
            Text(story.title)
               .font(.judulBiasa())
               .foregroundStyle(.black)
               .lineLimit(5)
            
            Text(story.hanzi)
               .font(.subJudul())
               .lineLimit(5)
               .foregroundStyle(.black.opacity(0.6))
            
            Text(story.pinyin)
               .font(.pinyin())
               .lineLimit(5)
               .foregroundStyle(.black.opacity(0.5))
         }
         .frame(maxWidth: .infinity, alignment: .leading)
//         .padding(.top, 8)
//         .padding(.bottom)
         
         HStack {
            PrimaryButtonView(isDisabled: isDisabled)
            
            CardMenuButtonView(isDisabled: isDisabled)
         }
      }
      .padding()
      .background(.white)
      .clipShape(.rect(cornerRadius: 24))
      .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
      .padding(.top, 30)
      .frame(width: 232)
      .frame(maxHeight: .infinity, alignment: .top)
   }
}

//#Preview {
//   HomeCardView(homeCard: .story1Thumbnail, storyName: "Go to Chinese Hotpot\nRestaurant", isDisabled: false, isComplete: false, story: <#Binding<Story_Example>#>)
//}
