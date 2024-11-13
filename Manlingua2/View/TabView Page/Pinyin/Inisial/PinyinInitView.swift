//
//  PinyinInitView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//

import SwiftUI

struct PinyinInitView: View {
   @EnvironmentObject var router: Router
   @StateObject var viewModel = LearnViewModel()
   @State var audioController = AudioController()
   
   var body: some View {
      //TODO: Jadiin ScrollView
      ScrollView {
         //TODO: Sizenya hard coded
         VStack(spacing: 16) {
            
            Text("Inisial")
               .font(.system(size: 25, weight: .bold))
               .padding(.top, 32)
            
            Image("Inisial")
               .resizable()
               .scaledToFit()
               .frame(width: 100, height: 100)
               .padding(.bottom, 16)

            
            VStack{
               Text("Tekan karakter untuk tahu cara")
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
               Text("pengucapannya")
                  .font(.system(size: 20))
                  .multilineTextAlignment(.center)
            }
            
             VStack(alignment: .leading, spacing: 12){
               ForEach(viewModel.pinyinInisial, id: \.self){ pinyins in
                  RowOfPinyinView(listPinyin: pinyins, audioController: $audioController)
               }
            }
            
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
      PinyinInitView()
         .environmentObject(Router())
   }
}
