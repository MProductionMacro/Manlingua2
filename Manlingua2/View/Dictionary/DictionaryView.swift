//
//  DictionaryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 03/10/24.
//
import SwiftUI

struct DictionaryView: View {
    @Environment(\.colorScheme) var colorScheme
   @EnvironmentObject var router: Router
   @StateObject var viewModel = DictionaryViewModel()
   @State var textToSpeech = TextToSpeech()
   var judul: String
   var displayMode: DictionaryDisplayMode
   
   var body: some View {
      ZStack {
         Color.blankBackground.ignoresSafeArea()
         
         VStack {
            Text(judul)
               .font(.title)
               .bold()
               .padding(.top, 16)
            
            Text("\(viewModel.vocabularies.count) Kata")
               .font(.subheadline)

             if viewModel.getVocabulary(displayMode).isEmpty {
                Spacer()
                VStack(alignment: .center){
                    Image(.orangeForBlank)
                        .resizable()
                        .frame(width: 158, height: 161)
                        .padding(.bottom, 36)
                         
                    Text("Ayo simpan kata yang ingin")
                        .font(.judulBiasa())
                        .foregroundColor(.emptyListText)
                        .opacity(colorScheme == .light ? 1 : 0.7)

                    Text("kamu pelajari kembali")
                        .font(.judulBiasa())
                        .foregroundColor(.emptyListText)
                        .opacity(colorScheme == .light ? 1 : 0.7)

                }
                Spacer()
                Spacer()
             }
             else{
                 ScrollView {
                     LazyVGrid(
                         columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)],
                         spacing: 16 // Vertical spacing
                     ) {
                         ForEach(viewModel.getVocabulary(displayMode), id: \.self) { vocabulary in
                             FlashcardDictionaryView(vocab: vocabulary, textToSpeech: $textToSpeech, viewModel: viewModel)
                                 .padding(0)
                                 //.background(.red)
                         }
                     }
                     .padding(.horizontal, 16)
                     .padding(.top, 16)
                 }
             }
         }
         .navigationBarItems(leading: Button(action: {
            router.popToRoot()
         }) {
            HStack {
               Image(systemName: "chevron.left")
               Text("Kembali")
            }
            .foregroundColor(.orangeDarkMode)
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


