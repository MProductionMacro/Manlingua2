//
//  DictionaryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 03/10/24.
//

import SwiftUI

struct DictionaryView: View {
   @EnvironmentObject var viewModel: StoryViewModel
   
   var body: some View {
      ZStack{
         Rectangle()
            .ignoresSafeArea()
            .foregroundColor(.white)
         VStack {
            Text("Dictionary")
               .font(.title)
               .bold()
               .frame(maxWidth: .infinity, alignment: .center)
               .padding(.top, 16)
               .foregroundColor(.black)
            
            Text("Story 1 - Chapter \(viewModel.currentStoryIndex + 1)")
               .font(.subheadline)
               .foregroundColor(.black)
               .frame(maxWidth: .infinity, alignment: .center)
               .padding(.bottom, 16)
            
            //TODO: Sizenya hard coded
            //FIXME: Index out of range
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
//               ForEach(0..<viewModel.currentStory.flashcard.count) { index in
//                  ZStack {
//                     FlashcardView(vocab: viewModel.currentStory.flashcard[index], width: 170, height: 236)
////                        .padding(0)
//                     RoundedRectangle(cornerRadius: 16)
//                        .stroke(.gray, lineWidth: 2)
//                     SoundButtonView(vocab: viewModel.currentStory.flashcard[index])
//                        .frame(width: 30, height: 30)
//                        .background(Color.white)
//                        .clipShape(Circle())
//                        .offset(x: 20, y: 75)
//                  }
//               }
//            }
//            .padding(.horizontal, 16)
            
            Spacer()
         }
         .navigationBarItems(leading: Button(action: {
            
         }) {
            HStack {
               Image(systemName: "chevron.left")
               Text("Back")
            }
            .foregroundColor(.orange)
         })
      }
   }
}

#Preview {
   DictionaryView()
      .environmentObject(StoryViewModel())
}
