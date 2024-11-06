//
//  UserAnswerView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 06/11/24.
//
import SwiftUI

struct UserAnswerView : View {
    
    @ObservedObject var viewModel: FlashcardViewModel
    @EnvironmentObject var router:Router
    
    var body : some View {
        VStack(spacing: 1){
            AnswerToolbarView(viewModel: viewModel)
            MicrophoneView()
            
        }
        .background(.customLightGray)
        .clipShape(CustomRoundedRectangle(cornerRadius: 25, corners: [.topLeft, .topRight]))

    }
}
