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
             Text("Nada".localized)
               .font(.system(size: 25, weight: .bold))
            
            Image("Nada")
               .resizable()
               .scaledToFit()
               .frame(width:100, height: 100)
               .padding(.bottom, 16)
            
            
            VStack{
                Text("Tekan karakter untuk tahu cara".localized)
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
                Text("pengucapannya".localized)
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
            }
            //.padding(.top, 32)
            .padding(.bottom, 32)

            RowOfPinyinView(listPinyin: viewModel.pinyinNada, audioController: $audioController)
         }
         .ignoresSafeArea()
         .frame(maxWidth: .infinity, maxHeight: .infinity)
         .padding(.top, UIScreen.main.bounds.height < 700 ? -40 : 32)
         
         Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                   
                    Text("Kembali".localized)
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
