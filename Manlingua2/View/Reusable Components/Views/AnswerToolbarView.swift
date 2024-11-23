//
//  AnswerToolbarView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 06/11/24.
//

import SwiftUI

struct AnswerToolbarView : View {
    @EnvironmentObject var router:Router
   @EnvironmentObject var viewModel: FlashcardViewModel
    @State var tts = TextToSpeech()
    var body : some View {
        VStack{
            Spacer()
            Spacer()
            HStack{
                Button(action:{
                    router.push(.dictionary(judul: "Kata Favorit".localized, displayMode: .favorite(isFromHome: false)))
                }, label: {
                    Image(systemName: "book")
                        .foregroundColor(.white)
                        .font(Font.subJudul())
                        .frame(width: 40, height: 40)
                        .background(Color.orange3)
                        .cornerRadius(8)
                })
                
                Spacer()
                Spacer()
                
                Button(action:{
                   tts.speak(text: viewModel.showVocabularies[viewModel.currentIndex].hanzi)
                }, label: {
                    Image(systemName: "speaker.wave.2")
                        .foregroundColor(.white)
                        .font(Font.subJudul())
                        .frame(width: 40, height: 40)
                        .background(Color.orange3)
                        .cornerRadius(8)
                })
                
                Spacer()
                Spacer()
                
                Button(action:{
                    tts.speakSlow(text: viewModel.showVocabularies[viewModel.currentIndex].hanzi)
                }, label: {
                    Image(systemName: "tortoise")
                        .foregroundColor(.white)
                        .font(Font.subJudul())
                        .frame(width: 40, height: 40)
                        .background(Color.orange3)
                        .cornerRadius(8)
                })
            }
            .padding(.horizontal, 40)
            Spacer()
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(.cardBackground)
    }
}
