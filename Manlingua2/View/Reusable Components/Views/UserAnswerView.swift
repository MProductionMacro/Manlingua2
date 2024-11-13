//
//  UserAnswerView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 06/11/24.
//
import SwiftUI

struct UserAnswerView : View {
   @EnvironmentObject var router:Router
   @EnvironmentObject var viewModel: FlashcardViewModel
   
   var body : some View {
      VStack(spacing: 1){
         BottomContainerButtons {
            
         } speakerAction: {
            
         } turtleAction: {
            
         }
         
         Divider()
         
         MicrophoneModalityView { result in
            viewModel.apiResult = result
            viewModel.showMicrophone = false
         }
         .padding(.vertical, 24)
      }
      .background(.cardBackground)
      .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))
      
   }
}
