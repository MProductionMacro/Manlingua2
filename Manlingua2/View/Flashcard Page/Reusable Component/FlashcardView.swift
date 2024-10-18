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
    @State var isFillHeart = false
    var body: some View{
        VStack{
            Text("\(vocab.meaning)")
                .font(Font.bold32())
                .padding(.horizontal, 30)
            
            Image("商量")
                .resizable()
                .frame(width: 150, height: 150)
            
            VStack{
                Text("\(vocab.hanzi)")
                    .font(Font.bold32())
                    
                HStack(spacing: 24){
                    Text("\(vocab.pinyin)")
                        .font(Font.bold24())
                    
                    Button(action: {
                        
                        if isFillHeart{
                            SwiftDataServices.shared.deleteData(vocab)
                            print("Masuk sini")
                        }
                        else{
                            SwiftDataServices.shared.addData(vocab)

                        }
                        isFillHeart.toggle()

                        print("Masuk")
                        //SwiftDataServices.shared.addData(vocab)
                        //SwiftDataServices.shared.deleteAll()
                    },label:{
                        Image(systemName: isFillHeart ? "heart.fill" : "heart")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                            .frame(width: 60, height: 60)
                            .background(.orange)
                            .cornerRadius(180)
                    })

                }
            }
        }
        .onAppear{
            isFillHeart = SwiftDataServices.shared.isVocabExist(vocab: vocab)
        }
        .frame(width: 300, height: 420)
        //310
        //.frame(width: 354.55, height: 440)
        //.frame(width: 390, height: 458)
        .background(.white)
        .cornerRadius(36)
    }
}

#Preview {
    FlashcardView(vocab: Vocabulary(hanzi: "Wowo", pinyin: "Lala", meaning: "Labu"))
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
