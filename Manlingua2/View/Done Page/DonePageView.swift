//
//  DonePageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 17/10/24.
//

import SwiftUI


struct DonePageView: View {
   
   @State private var currentPage : DonePageString = .flashCard
   @State private var currentPart : PartOfTheStory = .first
   @EnvironmentObject var viewModel: FlashcardViewModel
   @EnvironmentObject var router: Router
   
   var body: some View {
      ZStack{
         VStack(spacing: 10){
            Text(DonePageModel.title)
               .font(.system(size: 40))
               .fontWeight(.bold)
               .padding(12)
            Text(DonePageModel.description)
               .font(.system(size: 20))
            
            Text(currentPage == .flashCard ? "Flashcard Harian" : currentPart.titleOfDescription )
               .font(.system(size: 20))
               .padding(.bottom, 60)
            
            Image(DonePageModel.imageName)
               .frame(width: 335, height: 225)
               .padding(.bottom, 50)
            
            Button (action: {
               router.popToRoot()
            }){
               HStack {
                  Image(systemName: DonePageModel.bookSymbol)
                  Text(DonePageModel.returnToStoryTxt)
                     .font(.system(size: 20))
               }
               .foregroundStyle(Color.white)
               .padding()
               .frame(width: DonePageModel.buttonWidth, height: DonePageModel.buttonHeight)
               .background(
                  RoundedRectangle(cornerRadius: 16)
                     .fill(Color.orange)
               )
            }
            
            Button (action: {
               print("Button (Ulangi) Pressed")
               viewModel.showDonePage = false
               viewModel.currentIndex = 0
               viewModel.reshuffleCards()
            }){
               HStack {
                  Image(systemName: DonePageModel.returnSymbol)
                  Text("Ulangi \(currentPage.page)")
                     .font(.system(size: 20))
                  
               }
               .foregroundStyle(Color.orange)
               .padding()
               .frame(width: DonePageModel.buttonWidth, height: DonePageModel.buttonHeight)
               .overlay(
                  RoundedRectangle(cornerRadius: 16)
                     .stroke(Color.orange, lineWidth: 2)
               )
            }
            
         }
      }
   }
}

/*
 #Preview {
 DonePageView()
 }
 */
enum DonePageString: String, CaseIterable{
   case story
   case flashCard
   
   var page : String{
      switch self {
      case .story : return "Cerita"
      case .flashCard : return "Flashcard"
      }
   }
}

enum PartOfTheStory: CaseIterable{
   case first
   case second
   case third
   // add more
   
   var titleOfDescription: String{
      switch self {
      case .first : return "Bagian 1 - Perkenalan Nama"
      case .second : return "Bagian 2 - Perkenalan Umur"
      case .third : return "Bagian 3 - Perkenalan Pekerjaan"
      }
   }
}

struct DonePageModel{
   static let title = "Selamat!"
   static let description = "Kamu telah menyelesaikan"
   static let returnToStoryTxt = "Balik ke cerita"
   static let bookSymbol = "books.vertical"
   static let returnSymbol = "return"
   
   static let imageName = "congratulationImage"
   
   static let buttonWidth : CGFloat = 361
   static let buttonHeight : CGFloat = 64
}
