//
//  PinyinNadaView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//

import SwiftUI

struct PinyinNadaView: View {
   @EnvironmentObject var router: Router
   @StateObject var viewModel = LearnViewModel()
   @State var audioController = AudioController()
   
   var body : some View{
      ScrollView{
         VStack(spacing: 16){
            Text("Nada")
               .font(.system(size: 25, weight: .bold))
               .padding(.top, 32)
            
            Image("Nada")
               .resizable()
               .scaledToFit()
               .frame(width:100, height: 100)
               .padding(.bottom, 16)
            
            
            VStack{
               Text("Tekan karakter untuk tahu cara")
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
               Text("pengucapannya")
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
            }
            //.padding(.top, 32)
            .padding(.bottom, 32)

            RowOfPinyinView(listPinyin: viewModel.pinyinNada, audioController: $audioController)
         }
         .ignoresSafeArea()
      }
      .background(.blankBackground)
      .toolbar {
          ToolbarItem(placement: .topBarLeading) {
             HStack(alignment: .top){
                Button(action:{
                   router.pop()
                }){
                   Image(systemName: "chevron.left")
                      .foregroundColor(.orangeDarkMode)
                      .font(.semibold16())
                      .bold()
                   
                   Text("Kembali")
                      .foregroundColor(.orangeDarkMode)
                      .font(.semibold20())
                }
             }
          }
      }
   }
}

#Preview {
   NavigationView{
      PinyinNadaView()
         .environmentObject(Router())
   }
}
