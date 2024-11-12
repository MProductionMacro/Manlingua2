//
//  DonePageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 17/10/24.
//

import SwiftUI

//Ini nanti gak dipake, nanti dipakenya yang DonePageView2
struct DonePageView: View {
   var currentPage : DonePageString
   var currentPart : PartOfTheStory
   
   @EnvironmentObject var viewModel: FlashcardViewModel
   @EnvironmentObject var router: Router
   
   var body: some View {
      ZStack{
         VStack(spacing: 10){
            Text("Selamat!")
               .font(.system(size: 40))
               .fontWeight(.bold)
               .padding(12)
            
            Text("Kamu telah menyelesaikan")
               .font(Font.judulBiasa())
               .foregroundColor(.darkGrey)
            
            Text(currentPage == .flashCard ? "Flashcard Harian" : currentPart.titleOfDescription )
               .font(Font.judulBiasa())
               .foregroundColor(.darkGrey)
               .padding(.bottom, 60)
            
            Image(DonePageModel.imageName)
               .frame(width: 335, height: 225)
               .padding(.bottom, 50)
            
            
            HStack{
               Button (action: {
                  print("Button (Ulangi) Pressed")
                  viewModel.showDonePage = false
                  viewModel.currentIndex = 0
                  viewModel.reshuffleCards()
                  router.pop()
               }){
                  HStack {
                     Image(systemName: DonePageModel.returnSymbol)
                     Text("Ulang")
                        .font(.system(size: 20))
                  }
                  .foregroundStyle(Color.orange3)
                  .padding()
                  .frame(width: 170, height: DonePageModel.buttonHeight)
                  .overlay(
                     RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.orange3, lineWidth: 2)
                  )
               }
               
               Spacer()
               
               Button (action: {
                  print("Button (Ulangi) Pressed")
                  viewModel.showDonePage = false
                  viewModel.currentIndex = 0
                  viewModel.reshuffleCards()
               }){
                  HStack {
                     Image(systemName: "bookmark")
                     Text("Favorit")
                        .font(.system(size: 20))
                     
                  }
                  .foregroundStyle(Color.orange3)
                  .padding()
                  .frame(width: 170, height: DonePageModel.buttonHeight)
                  .overlay(
                     RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.orange3, lineWidth: 2)
                  )
               }
            }
            .frame(width: DonePageModel.buttonWidth)
            
            Button (action: {
               router.popToRoot()
            }){
               HStack {
                  Image(systemName: DonePageModel.houseSymbol)
                  Text(DonePageModel.returnToStoryTxt)
                     .font(.system(size: 20))
               }
               .foregroundStyle(Color.white)
               .padding()
               .frame(width: DonePageModel.buttonWidth, height: DonePageModel.buttonHeight)
               .background(
                  RoundedRectangle(cornerRadius: 16)
                     .fill(Color.orange3)
               )
            }
         }
      }
   }
}



struct DonePageView2: View {
   
   var displayMode: DonePageDisplayMode
   
   @EnvironmentObject var viewModel: FlashcardViewModel
   @EnvironmentObject var router: Router
   
   var body: some View {
      ZStack{
         VStack(spacing: 10){
            Text("Selamat!")
               .font(.judulBesar())
               .padding(12)
            
            Text("Kamu telah menyelesaikan")
               .font(Font.judulBiasa())
               .foregroundColor(.darkGrey)
            
            if case .story(let id, let judul) = displayMode {
               Text("Bagian \(id) - \(judul)")
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
            
            
            HStack(spacing: 8){
               Button (action: {
                  //                        print("Button (Ulangi) Pressed")
                  //                        viewModel.showDonePage = false
                  //                        viewModel.currentIndex = 0
                  //                        viewModel.reshuffleCards()
                  //                        router.pop()
               }){
                  HStack {
                     Image(systemName: DonePageModel.returnSymbol)
                        .font(.button())
                     
                     Text("Ulang")
                        .font(.button())
                  }
                  .frame(maxWidth: .infinity)
                  .padding(.vertical, 8)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
               
               Spacer()
               
               Button (action: {
                  //                        print("Button (Ulangi) Pressed")
                  //                        viewModel.showDonePage = false
                  //                        viewModel.currentIndex = 0
                  //                        viewModel.reshuffleCards()
               }){
                  HStack {
                     Image(systemName: "bookmark")
                        .font(.button())
                        
                     Text("Favorit")
                        .font(.button())
                     
                  }
                  .frame(maxWidth: .infinity)
                  .padding(.vertical, 8)
//                  .foregroundStyle(Color.orange3)
//                  .padding()
//                  .frame(width: 170, height: DonePageModel.buttonHeight)
//                  .overlay(
//                     RoundedRectangle(cornerRadius: 16)
//                        .stroke(Color.orange3, lineWidth: 2)
//                  )
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
            }
            .padding(.horizontal)
//            .frame(width: DonePageModel.buttonWidth)
            
            Button (action: {
               router.popToRoot()
            }){
               HStack {
                  Image(systemName: DonePageModel.houseSymbol)
                     .font(.button())
                  Text(DonePageModel.returnToStoryTxt)
                     .font(.button())
               }
               .frame(maxWidth: .infinity)
               .padding(.vertical, 8)
//               .foregroundStyle(Color.white)
//               .padding()
//               .frame(width: DonePageModel.buttonWidth, height: DonePageModel.buttonHeight)
//               .background(
//                  RoundedRectangle(cornerRadius: 16)
//                     .fill(Color.orange3)
//               )
            }
            .buttonStyle(PrimaryButton(isDisabled: false))
            .padding(.horizontal)
         }
      }
   }
}


#Preview {
   DonePageView2(displayMode: .story(id: 1, judul: "Perkenalan Nama"))
}

#Preview{
   DonePageView(currentPage: .story, currentPart: .first)
}
