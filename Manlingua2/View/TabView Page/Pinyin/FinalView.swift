//
//  FinalView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct FinalView: View {
   @EnvironmentObject var viewModel: LearnViewModel
   @EnvironmentObject var router: Router
   
   var body: some View {
      VStack {
         // This HStack will stick to the top
         HStack {
            Button(action: {
               router.pop()
            }) {
               HStack {
                  Image(systemName: "chevron.left")
                     .foregroundColor(.orange)
                  Text("Back")
                     .foregroundColor(.orange)
               }
            }
            Spacer()
         }
         .padding(.leading)
         .padding(.top) // Optional: Add padding to give some space from the top
         .background(Color.white) // Ensure the background matches your desired background
         
         // The rest of the content
         ScrollView { // Wrapping the main content in a ScrollView if content is large
            VStack {
               Text("Pin Yin Final")
                  .font(.system(size: 25, weight: .bold))
                  .foregroundStyle(.black)
                  .padding(15)
               Image("final")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 150, height: 150)
                  .padding(15)
               Text("Try to tap these character to know how to")
                  .font(.system(size: 18))
                  .foregroundStyle(.black)
               Text("pronounce it")
                  .font(.system(size: 18))
                  .foregroundStyle(.black)
                  .padding(.bottom, 10)
               VStack {
                  //TODO: Pake LazyHStack aja?
                  LazyVGrid(columns: [
                     GridItem(.flexible()),
                     GridItem(.flexible()),
                     GridItem(.flexible()),
                     GridItem(.flexible())
                  ], spacing: 16){
                     ForEach(0..<viewModel.pinyinFinal.count, id: \.self) { element in
                        PinyinSoundCardView(text: viewModel.pinyinFinal[element].pinyin, speak:  viewModel.pinyinFinal[element].sound)
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
   }
}

#Preview {
   FinalView()
      .environmentObject(LearnViewModel())
      .environmentObject(Router())
}
