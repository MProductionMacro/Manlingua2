//
//  PinyinInitView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 09/10/24.
//

import SwiftUI

struct PinyinInitView: View {
    @StateObject var viewModel = LearnViewModel()
   
    var body: some View {
        //TODO: Jadiin ScrollView
        ScrollView {
            //TODO: Sizenya hard coded
            VStack(spacing: 16) {
                Text("Inisial")
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.black)

                Image("Initial")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
             
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
                    ForEach(viewModel.pinyinInisial, id: \.self){ pinyins in
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
                HStack(alignment: .top) {
                    Button(action: {
                        //router.pop()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.orange3)
                            .font(.title3)
                            .fontWeight(.bold)
                      
                        Text("Kembali")
                            .foregroundColor(.orange3)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}


#Preview {
    NavigationView{
        PinyinInitView()
    }
}
