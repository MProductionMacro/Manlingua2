//
//  FlashcardDictionaryView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 17/10/24.
//

import SwiftUI
/*
struct FlashcardDictionaryView: View {
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

   }
}
*/

struct FlashcardDictionaryView: View {
    //let vocab: String
    let vocab: Vocabulary
    var width: CGFloat = 300
    var height: CGFloat = 200
    @State var textToSpeech = TextToSpeech()
    
    var body: some View{
        VStack{
            Text("\(vocab.meaning)")
                .font(Font.judulBiasa())
                .padding(.horizontal, 30)
                //.background(.red)
            
            Image("商量")
                .resizable()
                .frame(width: 60, height: 60)
            
            VStack{
                Text("\(vocab.hanzi)")
                    .font(Font.judulBiasa())
                    
                HStack(spacing: 24){
                    Text("\(vocab.pinyin)")
                        .font(Font.normalText())
                        
                    Button(action:{
                        textToSpeech.speak(text: vocab.hanzi)
                    }, label:{
                        Image(systemName: "speaker.wave.2")
                            .font(Font.hanzi())
                            .foregroundStyle(.white)
                            .frame(width: 45, height: 45)
                            .background(.orange)
                            .cornerRadius(180)
                    })
                }
            }
        }
        .frame(width: 170, height: 203)
        .zIndex(2)
        //310
        //.frame(width: 354.55, height: 440)
        //.frame(width: 390, height: 458)
        .background(.white)
        .cornerRadius(16.98)
        .overlay{
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 0.47)
        }
        
    }
}

#Preview {
    /*
     FlashcardDictionaryView(vocab: "谢谢", width: 300, height: 400)
     */
    FlashcardDictionaryView(vocab: Vocabulary(hanzi: "Wowo", pinyin: "Lala", meaning: "Labu"))

}
