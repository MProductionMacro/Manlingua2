//
//  DonePageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 17/10/24.
//

import SwiftUI

struct DonePageView: View {
   @EnvironmentObject var viewModel: FlashcardViewModel
   @EnvironmentObject var router: Router
   var displayMode: DonePageDisplayMode
   
   var body: some View {
      ZStack{
         Color.blankBackground
         VStack(spacing: 10){
            Text("Selamat!")
               .font(.system(size: 40))
               .fontWeight(.bold)
               .padding(12)
            
            Text("Kamu telah menyelesaikan")
               .font(Font.judulBiasa())
               .foregroundColor(.darkGrey)
            
            if case .story(let storyId, let subChapterId) = displayMode {
               Text("Bagian \(subChapterId) - \(DonePageTitle.title(storyId: storyId, subChapterId: subChapterId))")
                  .font(Font.judulBiasa())
                  .foregroundColor(.darkGrey)
                  .padding(.bottom, 60)
            }
            else{
               Text("Flashcard Harian")
                  .font(Font.judulBiasa())
                  .foregroundColor(.darkGrey)
                  .padding(.bottom, 60)
            }
            
            Image(DonePageModel.imageName)
               .frame(width: 335, height: 225)
               .padding(.bottom, 50)
            
            HStack {
               Button (action: {
                  viewModel.showDonePage = false
                  viewModel.currentIndex = 0
                  viewModel.reshuffleCards()
                  router.pop()
               }){
                  HStack(alignment: .center) {
                     Image(systemName: DonePageModel.returnSymbol)
                        .font(.button())
                     
                     Text("Ulang")
                        .font(.button())
                  }
                  .frame(maxWidth: .infinity)
                  .padding(.vertical, 8)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
               
               Button (action: {
                  viewModel.showDonePage = false
                  viewModel.currentIndex = 0
                  viewModel.reshuffleCards()
                  
                  switch displayMode {
                  case .flashcard:
                     router.push(.dictionary(judul: "Kata - kata favorit", displayMode: .favorite))
                  case .story(let storyId, let subChapterId):
                     router.push(.importantNote(displayMode: .subChapter(storyId: storyId, subChapterId: subChapterId)))
                  }
               }){
                  HStack {
                     Image(systemName: displayMode == .flashcard ? "bookmark" : "list.clipboard")
                        .font(.button())
                     
                     Text(displayMode == .flashcard ? "Favorit" : "Catatan")
                        .font(.button())
                  }
                  .frame(maxWidth: .infinity)
                  .padding(.vertical, 8)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
            }
            .padding(.horizontal)
            
            Button (action: {
               router.popToRoot()
            }){
               HStack {
                  Image(systemName: DonePageModel.houseSymbol)
                     .font(.button())
                  
                  Text(DonePageModel.returnToStoryTxt)
                     .font(.button())
               }
               .foregroundStyle(Color.white)
               .frame(maxWidth: .infinity)
               .padding()
            }
            .padding(.horizontal)
            .buttonStyle(PrimaryButton(isDisabled: false))
         }
      }
   }
}

#Preview {
   DonePageView(displayMode: .story(storyId: 1, subChapterId: 1))
   
}
