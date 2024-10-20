//
//  SidebarButton.swift
//  Manlingua2
//
//  Created by Paulus Michael on 13/10/24.
//

import SwiftUI

struct SidebarButton: View {
   @EnvironmentObject var router: Router
   @State private var showContent: Bool = false
   @EnvironmentObject var storyViewModel: StoryViewModel
   @EnvironmentObject var homeViewModel: HomeViewModel
   
   @State var textToSpeech = TextToSpeech()
   
   @Binding var chatIndex: Int
   var storyId: Int
   
   var body: some View {
      HStack(spacing: 0) {
         Button(action: {
            withAnimation {
               showContent.toggle()
            }
         }) {
            Image(systemName: showContent ? "chevron.right" : "chevron.left")
               .font(.judulBiasa())
               .foregroundColor(.white)
               .padding(.vertical, 11)
               .padding(.horizontal, 8)
         }
         
         if showContent {
            HStack(spacing: 12) {
               Button(action: {
                  //router.push(.dictionary(storyId: storyId))
                  router.push(.dictionary(judul: homeViewModel.stories_example[storyId-1].title, storyId: storyId, showFavoriteVocab: false))
               }) {
                  Image(systemName: "book.fill")
                     .frame(width: 24, height: 24)
                     .padding(12)
                     .foregroundStyle(.white)
                     .background(.orange3)
                     .clipShape(.rect(cornerRadius: 12))
               }
               
               Button(action: {
                  // Action for speaker icon
                  textToSpeech.speak(text: storyViewModel.chat_example[chatIndex].hanzi)
               }) {
                  Image(systemName: "speaker.wave.2.fill")
                     .frame(width: 24, height: 24)
                     .padding(12)
                     .foregroundStyle(.white)
                     .background(.orange3)
                     .clipShape(.rect(cornerRadius: 12))
               }
               
               Button(action: {
                  // Action for turtle icon
                  textToSpeech.speakSlow(text: storyViewModel.chat_example[chatIndex].hanzi)
               }) {
                  Image(systemName: "tortoise.fill")
                     .frame(width: 24, height: 24)
                     .padding(12)
                     .foregroundStyle(.white)
                     .background(.orange3)
                     .clipShape(.rect(cornerRadius: 12))
               }
            }
            .padding(.horizontal, 12)
            .transition(.move(edge: .trailing)) // Animate appearance from the left side
         }
      }
      .padding(.vertical, 11)
      .background(.customYellow)
      .clipShape(CustomRoundedRectangle(cornerRadius: 20, corners: [.topLeft, .bottomLeft]))
      .frame(maxWidth: .infinity, alignment: .trailing)
   }
}

//#Preview {
//   SidebarButton()
//}
