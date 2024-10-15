//
//  PinyinFinalView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//

import SwiftUI

struct PinyinFinalView: View {
    @StateObject var viewModel = LearnViewModel()
    
    var body : some View{
        ScrollView{
            VStack(spacing: 16){
                Text("Final")
                    .font(.system(size: 25, weight: .bold))

                Image("final")
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
     
                VStack(alignment: .leading){
                    Text("Final Tunggal")
                        .font(Font.judulBiasa())
                        .padding(.horizontal)
                    
                    ForEach(viewModel.pinyinFinalTunggal, id: \.self){ pinyins in
                        RowOfPinyinView(listPinyin: pinyins)
                    }
                    
                    Text("Final Ganda")
                        .font(Font.judulBiasa())
                        .padding(.horizontal)

                    ForEach(viewModel.pinyinFinalGanda, id: \.self){ pinyins in
                        RowOfPinyinView(listPinyin: pinyins)
                    }
                }
            }
            .background(.white)
            .ignoresSafeArea()
            .padding(.top)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(alignment: .top){
                    Button(action:{
                        
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
        PinyinFinalView()

    }
}

