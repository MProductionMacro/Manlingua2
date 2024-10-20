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
    var body : some View{
        ScrollView{
            VStack(spacing: 16){
                Text("Nada")
                    .font(.system(size: 25, weight: .bold))

                Image("NadaNew")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100, height: 100)
                    
                
                VStack{
                    Text("Tekan karakter untuk tahu cara")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                    Text("pengucapannya")
                        .font(.system(size: 20))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                }
                //.padding(.top, 32)
                .padding(.bottom, 32)
                
                //Text(" ")
                
                RowOfPinyinView(listPinyin: viewModel.pinyinNada)
            }
            .background(.white)
            .ignoresSafeArea()
            .padding(.top)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(alignment: .top){
                    Button(action:{
                        router.pop()
                    }){
                        Image(systemName: "chevron.left")
                            .foregroundColor(.orange3)
                            .font(.title3)
                            .bold()
                        
                        Text("Kembali")
                            .foregroundColor(.orange3)
                            .bold()
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
