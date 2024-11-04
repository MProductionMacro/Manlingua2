//
//  FlashcardDictionaryView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 17/10/24.
//

import SwiftUI

struct FlashcardDictionaryView: View {
    let vocab: Vocabulary
    @State var textToSpeech = TextToSpeech()
    @State var isBookmarked = false
    @EnvironmentObject var router: Router

    var body: some View{
        VStack(alignment: .center, spacing: 11){
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
                    .font(.judulBiasa())
                    .foregroundStyle(.orange3)
                    .padding(.trailing, 8)
            })
            .frame(width: 138, alignment: .trailing)


            Text("\(vocab.meaning)")
                 .font(Font.subJudul())
             //.padding(.horizontal, 30)
            //.background(.red)

            Image("\(vocab.meaning)")
                .resizable()
                .frame(width: 60, height: 60)

            VStack(spacing: 6){
                Text("\(vocab.hanzi)")
                    .font(Font.subJudul())

                HStack(spacing: 24){
                    Text("\(vocab.pinyin)")
                        .font(Font.normalText())
                
                    Button(action:{
                        textToSpeech.speak(text: vocab.hanzi)
                    }, label:{
                        Image(systemName: "speaker.wave.2")
                            .font(Font.pinyin())
                            .foregroundStyle(.white)
                            .frame(width: 32, height: 32)
                            .background(.orange3)
                            .cornerRadius(180)
                    })
                }
                 
                Spacer()
            }
        }
        .onAppear{
            isBookmarked = SwiftDataServices.shared.isVocabExist(vocab: vocab)
        }
        .frame(width: 170, height: 208)
        .zIndex(2)
        .background(.white)
        .cornerRadius(16.98)
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 0)
    }
}

#Preview {
   FlashcardDictionaryView(vocab: Vocabulary(hanzi: "Wowo", pinyin: "Lala", meaning: "Bisnis"))
        .environmentObject(Router())
   
}
