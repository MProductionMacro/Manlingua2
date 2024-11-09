//
//  BottomStoryButtons.swift
//  Manlingua2
//
//  Created by Paulus Michael on 09/11/24.
//

import SwiftUI

struct BottomStoryButtons: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var homeViewModel: HomeViewModel
   @EnvironmentObject var storyViewModel: StoryViewModel
   
   @Binding var currentIndex: Int
   var storyId: Int
   
   @State var textToSpeech = TextToSpeech()
   
   var body: some View {
      HStack{
         Button {
            router.push(.dictionary(judul: homeViewModel.stories_example[storyId - 1].title, displayMode: .story(id: storyId)))
         } label: {
            Image(systemName: "book")
               .font(.titleKe2())
               .foregroundStyle(.orange3)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
         
         Button {
            textToSpeech.speak(text: storyViewModel.chat_example[currentIndex].hanzi)
         } label: {
            Image(systemName: "speaker.wave.2")
               .font(.titleKe2())
               .foregroundStyle(.orange3)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
         
         Button {
            textToSpeech.speak(text: storyViewModel.chat_example[currentIndex].hanzi)
         } label: {
            Image(systemName: "tortoise")
               .font(.titleKe2())
               .foregroundStyle(.orange3)
               .frame(maxWidth: .infinity)
         }
         .buttonStyle(CustomOnTapButton())
      }
   }
}

#Preview {
   BottomStoryButtons(currentIndex: .constant(1), storyId: 1)
}
