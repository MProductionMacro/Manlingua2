import SwiftUI
/*
 struct BottomFlashcardContainerView: View {
 @EnvironmentObject var router: Router
 @EnvironmentObject var flashcardViewModel: FlashcardViewModel
 
 @State var textToSpeech = TextToSpeech()
 
 var body: some View {
 VStack(spacing: 0){
 BottomContainerButtons {
 router.push(.dictionary(judul: "Kata Favorit", displayMode: .favorite))
 } speakerAction: {
 textToSpeech.speak(text: flashcardViewModel.showVocabularies[flashcardViewModel.currentIndex].hanzi)
 } turtleAction: {
 textToSpeech.speakSlow(text: flashcardViewModel.showVocabularies[flashcardViewModel.currentIndex].hanzi)
 }
 
 Divider()
 
 MicrophoneModalityView { answer in
 
 }
 .padding(.vertical, 24)
 }
 .frame(maxWidth: .infinity)
 .background(.cardBackground)
 .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
 }
 }
 
 #Preview {
 BottomFlashcardContainerView()
 .frame(maxHeight: .infinity)
 .background(.black)
 .environmentObject(Router())
 .environmentObject(FlashcardViewModel())
 .environment(\.colorScheme, .dark)
 }
 */

struct BottomFlashcardContainerView: View {
   @Binding var answer:String
   @Binding var isCorrect: Bool
   @Binding var hasAnswered: Bool
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var flashcardViewModel: FlashcardViewModel
   /*
    @EnvironmentObject var router: Router
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var storyViewModel: StoryViewModel
    */
   @State private var textToSpeech = TextToSpeech()
   @State private var isSpeaking = false
   
   var body: some View {
      VStack(spacing: 0) {
         BottomContainerButtons(bookAction: {
             router.push(.dictionary(judul: "Kata Favorit".localized, displayMode: .favorite(isFromHome: false)))
         }, speakerAction: {
            isSpeaking = true
            textToSpeech.speak(text: flashcardViewModel.showVocabularies[flashcardViewModel.currentIndex].hanzi)
         }, turtleAction: {
            textToSpeech.speakSlow(text: flashcardViewModel.showVocabularies[flashcardViewModel.currentIndex].hanzi)
         }, isSpeaking: $isSpeaking)
         
         Divider()
         
         MicrophoneModalityView() { answer in
             isCorrect = flashcardViewModel.checkAnswer(answer: answer)
             withAnimation(.easeInOut(duration: 0.45)){
                 //(answer == flashcardViewModel.showVocabularies[flashcardViewModel.currentIndex].hanzi)
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                     withAnimation{
                         hasAnswered = true
                     }
                 }
               //hasAnswered = true
            }
         }
         .padding(.vertical, 24)
         .transition(.move(edge: .bottom))
      }
      .frame(maxWidth: .infinity)
      .background(.cardBackground)
      .clipShape(CustomRoundedRectangle(cornerRadius: 24, corners: [.topLeft, .topRight]))
      //.animation(.easeInOut(duration: 0.3), value: chatType == .question)
   }
}
