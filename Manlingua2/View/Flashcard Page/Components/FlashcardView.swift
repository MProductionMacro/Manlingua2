//
//  FlashcardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct FlashcardView: View {
    //let vocab: String
    let vocab: Vocabulary
    var width: CGFloat = 300
    var height: CGFloat = 200
    @State var isBookmarked = false
    var body: some View{
        VStack(alignment: .center, spacing: 16){
            Button(action:{
                if isBookmarked{
                    SwiftDataServices.shared.deleteData(vocab)
                }
                else{
                    SwiftDataServices.shared.addData(vocab)
                }
                isBookmarked.toggle()
            }, label: {
            
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.titleKe2())
                    .foregroundStyle(.orange3)
                    .padding(.trailing, 8)
            })
            .frame(width: 268, alignment: .trailing)
            
            Text("\(vocab.meaning)")
                .font(Font.bold24())
                .padding(.horizontal, 30)
            
            Image("\(vocab.pinyin)")
                .resizable()
                .frame(width: 150, height: 150)
            
            VStack(spacing: 5){
                Text("\(vocab.hanzi)")
                    .font(Font.bold24())
                
                Text("\(vocab.pinyin)")
                    .font(Font.judulBiasa())
            }

            
            VStack(alignment: .leading){
                Text("Contoh kalimat")
                    .font(Font.boldText())
                Text("\(vocab.pinyinSentence)")
                    .font(Font.normalText())
                Text("\(vocab.hanziSentence)")
                    .font(Font.normalText())
                Text("\(vocab.meaningSentence)")
                    .font(Font.normalText())
            }
            .frame(width: 210, alignment: .leading)
            
            Spacer()
        }
        .onAppear{
            isBookmarked = SwiftDataServices.shared.isVocabExist(vocab: vocab)
        }
        .frame(width: 300, height: 426)
        //310
        //.frame(width: 354.55, height: 440)
        //.frame(width: 390, height: 458)
        .background(.white)
        .cornerRadius(17)
        
    }
}

#Preview {
    FlashcardView(vocab: Vocabulary(hanzi: "Wowo", pinyin: "Lala", meaning: "Bisnis", hanziSentence: "Wowo", pinyinSentence: "Lala", meaningSentence: "Bisnis", language: "en"))
}




/*
struct FlashcardView: View {
   let vocab: String
   var width: CGFloat = 300
   var height: CGFloat = 200
   
   var body: some View {
      //        let soundButtonSize = min(40, 40)
      ZStack {
         Image(vocab)
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
      }
      //            .shadow(radius: 1.5)
      //            .overlay(
      //                SoundButton(vocab: vocab)
      //                    .frame(width: 30, height: 30)
      //                    .padding(.top, height * 0.65)
      //                    .padding(.leading, width * 0.24)
      //            )
   }
}

#Preview {
   FlashcardView(vocab: "谢谢", width: 300, height: 400)
}
*/
