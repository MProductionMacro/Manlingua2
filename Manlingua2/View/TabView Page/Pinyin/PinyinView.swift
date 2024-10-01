//
//  PinyinView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct PinyinView: View {
   @ObservedObject var viewModel: LearnViewModel
   @EnvironmentObject var router: Router
   
   var body: some View {
      VStack(spacing: 32) {
         Text("Learn Pin Yin")
            .fontWeight(.heavy)
            .font(.system(size: 48))
            .foregroundStyle(.white)
            .padding(.top)
         
         PinYinExampleCardView()
            .padding(.horizontal)
         
         //TODO: Tambahin withAnimation aja
         VStack(spacing: 16) {
            Button(action: {
               router.push(.pinyinInisial)
            }) {
               PinYinNavigationButtonView(labelImage: .initialIcon, title: "Initial", content: "Initials are usually consonants")
            }
            
            Button(action: {
               router.push(.pinyinFinal)
            }) {
               PinYinNavigationButtonView(labelImage: .finalIcon, title: "Final", content: "Finals are usually made up of vowels")
            }
            
            Button(action: {
               router.push(.pinyinNada)
            }) {
               PinYinNavigationButtonView(labelImage: .toneIcon, title: "Tone", content: "Tones differentiate word meanings")
            }
         }
         .background(Color.clear)
         
         Spacer()
      }
      .background(Image(.pinyinBackground))
   }
}

#Preview {
   PinyinView(viewModel: LearnViewModel())
      .environmentObject(Router())
}
