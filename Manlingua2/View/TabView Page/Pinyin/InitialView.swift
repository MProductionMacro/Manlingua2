//
//  InitialView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct InitialView: View {
   @EnvironmentObject var viewModel: LearnViewModel
   @EnvironmentObject var router: Router
   
   let columns = [
      GridItem(.flexible(), alignment: .center),
      GridItem(.flexible(), alignment: .center),
      GridItem(.flexible(), alignment: .center),
      GridItem(.flexible(), alignment: .center),
   ]
   
   var body: some View {
      //TODO: Jadiin ScrollView
      ScrollView {
         //TODO: Sizenya hard coded
         VStack(spacing: 16) {
            Text("Pin Yin Initial")
               .font(.system(size: 25, weight: .bold))
               .foregroundStyle(.black)
            Image("Initial")
               .resizable()
               .scaledToFit()
               .frame(width: 100, height: 100)
            Text("Try to tap these character to know how to pronounce it")
               .font(.system(size: 18))
               .foregroundStyle(.black)
               .multilineTextAlignment(.center)
            
            LazyVGrid(columns: columns, spacing: 16) {
               ForEach(0..<viewModel.pinyinInit.count, id: \.self){ element in
                  PinyinSoundCardView(text: viewModel.pinyinInit[element].pinyin, speak:  viewModel.pinyinInit[element].sound)
               }
            }
            .padding(.horizontal)
         }
         .background(.white)
         .ignoresSafeArea()
         .padding(.top)
      }
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            HStack(alignment: .top) {
               Button(action: {
                  router.pop()
               }) {
                  Image(systemName: "chevron.left")
                     .foregroundColor(.orange3)
                     .font(.title3)
                     .bold()
                  
                  Text("Kembali")
                     .foregroundColor(.orange3)
                     .bold()
               }
            }
            
//            .padding(.leading)
         }
      }
   }
}

#Preview {
   NavigationStack {
      InitialView()
         .environmentObject(LearnViewModel())
         .environmentObject(Router())
   }
}
