//
//  InitialView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct InitialView: View {
   @EnvironmentObject var viewModel: LearnViewModel
   
   var body: some View {
      //TODO: Jadiin ScrollView
      HStack {
         Button(action: {
            viewModel.switchStage(to: .front)
         }) {
            Image(systemName: "chevron.left")
               .foregroundColor(.orange)
            Text("Back")
               .foregroundColor(.orange)
         }
         Spacer()
      }
      .padding(.leading)
      
      //TODO: Sizenya hard coded
      VStack {
         Text("Pin Yin Initial")
            .font(.system(size: 25, weight: .bold))
            .foregroundStyle(.black)
         Image("Initial")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
         Text("Try to tap these character to know how to")
            .font(.system(size: 18))
            .foregroundStyle(.black)
         Text("pronounce it")
            .font(.system(size: 18))
            .foregroundStyle(.black)
         
         VStack {
            LazyVGrid(columns: [
               GridItem(.flexible()),
               GridItem(.flexible()),
               GridItem(.flexible()),
               GridItem(.flexible()),
               GridItem(.flexible()),
               GridItem(.flexible())],
                      spacing: 16
            ) {
               ForEach(0..<viewModel.pinyinInit.count, id: \.self){ element in
                  PinyinSoundCardView(text: viewModel.pinyinInit[element].pinyin, speak:  viewModel.pinyinInit[element].sound)
//                     .padding(5)
               }
            }
            .padding(.horizontal, 20)
         }
         .padding(.bottom, 20)
      }
      .background(.white)
      .ignoresSafeArea()
   }
}

#Preview {
   InitialView()
      .environmentObject(LearnViewModel())
}
