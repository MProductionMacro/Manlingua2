//
//  DictionaryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 03/10/24.
//

import SwiftUI

struct DictionaryView: View {
   @EnvironmentObject var viewModel: StoryViewModel
    
    var judul: String = "Perkenalan"
    var isiKata: String = "33 Kata"
   
   var body: some View {
      ZStack{
         Rectangle()
            .ignoresSafeArea()
            .foregroundColor(.white)
         VStack {
             Text("\(judul)")
//                 .font(Font.title())
                 .foregroundStyle(.black)
                 .padding(.top, 2)
//            Text("Perkenalan")
               .font(.title)
               .bold()
               .frame(maxWidth: .infinity, alignment: .center)
               .padding(.top, 16)
               .foregroundColor(.black)
            
             Text("\(isiKata)")
               .font(.subheadline)
               .foregroundColor(.black)
               .frame(maxWidth: .infinity, alignment: .center)
               .padding(.bottom, 16)
            
            //TODO: Sizenya hard coded
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
               ForEach(0..<viewModel.currentStory.flashcard.count) { index in
                  ZStack {
                     FlashcardDictionaryView(vocab: viewModel.currentStory.flashcard[index], width: 170, height: 236)
//                        .padding(0)
                     RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 2)
                     SoundButtonView(vocab: viewModel.currentStory.flashcard[index])
                        .frame(width: 30, height: 30)
                        .background(Color.white)
                        .clipShape(Circle())
                        .offset(x: 20, y: 75)
                  }
               }
            }
            .padding(.horizontal, 16)
            
            Spacer()
         }
         .navigationBarItems(leading: Button(action: {
            
         }) {
            HStack {
               Image(systemName: "chevron.left")
               Text("Kembali")
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
