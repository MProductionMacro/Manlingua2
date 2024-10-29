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
               .padding(.bottom, 16)
            
            ScrollView {
               LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                  ForEach(viewModel.vocabularies, id: \.self) { vocabulary in
                     FlashcardDictionaryView(vocab: vocabulary)
                  }
               }
               .padding(.horizontal, 16)
               .padding(.top, 10)
            }
            .padding(.bottom, 15)
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

enum DictionaryDisplayMode: Equatable, Hashable {
   case favorite
   case story(id: Int)
}
