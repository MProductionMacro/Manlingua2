//
//  FlashcardDictionaryView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 17/10/24.
//
import SwiftUI

struct FlashcardDictionaryView: View {
    let vocab: Vocabulary
    @Binding var textToSpeech: TextToSpeech
    @State private var isBookmarked = false
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: DictionaryViewModel

    var body: some View{
        VStack(alignment: .center, spacing: 11){
            Button(action:{
                if isBookmarked{
                    SwiftDataServices.shared.deleteData(vocab)
                }
                else{
                    viewModel.addVocabulary(vocab)
                }
                isBookmarked.toggle()
            }, label: {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.judulBiasa())
                    .foregroundStyle(.orangeDarkMode)
                    .padding(.trailing, 8)
            })
            .frame(width: 138, alignment: .trailing)


            Text("\(vocab.meaning)")
                 .font(Font.subJudul())
             //.padding(.horizontal, 30)
            //.background(.red)

            Image("\(vocab.pinyin)")
                .resizable()
                .frame(width: 60, height: 60)

            VStack(spacing: 6){
                Text("\(vocab.hanzi)")
                    .font(Font.subJudul())

                HStack(spacing: 12){
                    Text("\(vocab.pinyin)")
                        .font(Font.normalText())
                
                    Button(action:{
                       textToSpeech.speak(text: vocab.hanzi)
                    }, label:{
                        Image(systemName: "speaker.wave.2")
                            .font(Font.button())
                            .foregroundStyle(.orangeDarkMode)
                            .frame(width: 32, height: 32)
                    })
                }
                 
                Spacer()
            }
        }
        .onAppear{
            isBookmarked = SwiftDataServices.shared.isVocabExist(vocab: vocab)
        }
        .frame(width: 160, height: 208)
        .zIndex(2)
        .background(.cardBackground)
        .cornerRadius(16.98)
        .shadow(color: .cardShadow.opacity(0.2), radius: 8, x: 0, y: 0)
    }
}

#Preview {
    FlashcardDictionaryView(vocab: Vocabulary(hanzi: "Wowo", pinyin: "Lala", meaning: "Bisnis", hanziSentence: "WoWo", pinyinSentence: "Lala", meaningSentence: "Bisnis", language: "en"), textToSpeech: .constant(TextToSpeech()), viewModel : DictionaryViewModel())
        .environmentObject(Router())
   
}
