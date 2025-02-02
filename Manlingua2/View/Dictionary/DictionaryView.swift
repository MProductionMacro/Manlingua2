import SwiftUI

struct DictionaryView: View {
   @Environment(\.colorScheme) var colorScheme
   @EnvironmentObject var router: Router
   @StateObject private var viewModel = DictionaryViewModel()
   @State private var textToSpeech = TextToSpeech()
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
            
             Text("\(viewModel.getNumberVocabularies()) " + "Kata".localized)
               .font(.subheadline)
           
             if viewModel.isVocabsEmpty() {
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
                     }
                  }
                  .padding(.horizontal, 16)
                  .padding(.top, 16)
               }
            }
         }
         .padding(.top, UIScreen.main.bounds.height < 700 ? -60 : 8)
         .navigationBarItems(leading: Button(action: {
             
             if displayMode == .favorite(isFromHome: true) {
               router.popToRoot()
            }else{
               router.pop()
            }

         }) {
            HStack {
                Image(systemName: "chevron.left")
                   .foregroundColor(.orangeDarkMode)
                   .font(.semibold16())
                   .bold()
                
                 Text("Kembali".localized)
                   .foregroundColor(.orangeDarkMode)
                   .font(.semibold20())
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



