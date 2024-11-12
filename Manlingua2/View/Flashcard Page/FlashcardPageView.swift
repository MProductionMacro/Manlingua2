//
//  LanguageSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct FlashcardPageView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: FlashcardViewModel
   @StateObject var singleton = UserDefaultSingleton.shared
   @State var tutorialOverlay: Int = 1
   @State var audioController = AudioController.shared
   @State private var showConfirmationAlert = false
   
   var body: some View {
      ZStack (alignment: .bottom){
         VStack {
            HStack(spacing: 4) {
               Button {
                  showConfirmationAlert = true
               } label: {
                  Image(systemName: "rectangle.portrait.and.arrow.right")
                     .resizable()
                     .frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.width * 0.07)
                     .foregroundStyle(.orange3)
               }
               .reusableAlert(
                  isPresented: $showConfirmationAlert,
                  alertData: AlertData(
                     type: .confirmation,
                     primaryAction: {
                        router.pop()
                     },
                     dismissAction: {
                        showConfirmationAlert = false
                     }
                  )
               )
               
               Spacer()
               
               ProgressView(value: viewModel.getProgress())
                  .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
            }
            .padding(.horizontal)
            
            Spacer()
            
            HStack(alignment: .top){
                ZStack(alignment: .top){
                    ForEach(0 ..< viewModel.showVocabularies.count, id: \.self) { index in
                        if index >= viewModel.currentIndex {
                              viewModel.createFlashcardView(for: index)
                                 .zIndex(Double(viewModel.showVocabularies.count - index))
                                 .opacity(viewModel.currentIndex == index ? 1 : 0)
                        }

                    }
                }
                .shadow(radius: 0, x: 0, y: 0)
            }
            .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 0)
            
            Spacer()
            
            BottomFlashcardContainerView()
         }
         .frame(maxHeight: .infinity)
         
         //          BottomContainerView(viewModel: viewModel, audioController: $audioController).onTapGesture{
         //              router.push(.donePage(currentPage: .story, currentPart: .first))
         //          }
         
         /*
          .overlay{
          if singleton.hasNotOpenFlashcardPage(){
          FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
          }
          }
          
          FlashcardSidebarButton(viewModel: viewModel){
          tutorialOverlay = tutorialOverlay + 1
          }
          .offset(y: 160)
          */
      }
      .frame(maxHeight: .infinity)
      .background(
         Image(.chatBackground)
            .scaledToFill()
      )
      .ignoresSafeArea(.container, edges: .bottom)
      .onAppear{
          viewModel.currentIndex = 0
          viewModel.reshuffleCards()
      }
   }
}

#Preview {
   FlashcardPageView()
      .environmentObject(Router())
      .environmentObject(FlashcardViewModel())
}


