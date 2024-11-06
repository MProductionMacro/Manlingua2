//
//  DictionaryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 03/10/24.
//
import SwiftUI

struct DictionaryView: View {
   @EnvironmentObject var router: Router
   @StateObject var viewModel = DictionaryViewModel()
   @State var textToSpeech = TextToSpeech()
   var judul: String
   var displayMode: DictionaryDisplayMode
   
   var body: some View {
      ZStack {
         Color.white.ignoresSafeArea()
         
         VStack {
            Text(judul)
               .font(.title)
               .bold()
               .foregroundColor(.black)
               .padding(.top, 16)
            
            Text("\(viewModel.vocabularies.count) Kata")
               .font(.subheadline)
               .foregroundColor(.black)
             
             ScrollView {
                 LazyVGrid(
                     columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)],
                     spacing: 16 // Vertical spacing
                 ) {
                     ForEach(viewModel.vocabularies, id: \.self) { vocabulary in
                         FlashcardDictionaryView(vocab: vocabulary, textToSpeech: $textToSpeech)
                             .padding(0)
                             //.background(.red)
                     }
                 }
                 .padding(.horizontal, 16)
                 .padding(.top, 16)
             }

         }
         .navigationBarItems(leading: Button(action: {
            router.pop()
         }) {
            HStack {
               Image(systemName: "chevron.left")
               Text("Kembali")
            }
            .foregroundColor(.orange)
         })
      }
      .navigationBarBackButtonHidden(true)
      .onAppear {
         viewModel.loadVocabularies(from: displayMode)
      }
   }
}

#Preview {
   NavigationView{
      DictionaryView(judul: "Story Vocabulary", displayMode: .story(id: 1))
   }
}


