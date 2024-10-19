//
//  FlashcardView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct FlashcardPageView: View {
   @ObservedObject var viewModel1: StoryViewModel
   @StateObject var viewModel = FlashcardViewModel()
   @State var tutorialOverlay: Int = 1
   
   @State var audioController = AudioController()
   
   var body: some View {
      ZStack {
         VStack {
            HStack(spacing: 4) {
               Button {
                  
               } label: {
                  Image(systemName: "rectangle.portrait.and.arrow.right")
                     .resizable()
                     .frame(width: 29, height: 24)
                     .foregroundStyle(.orange3)
               }
               Spacer()
               ProgressView(value: viewModel.getProgress())
                  .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
            }
            .padding(.horizontal)
            
            Spacer()
            
            ZStack{
               ForEach(0 ..< viewModel.showVocabularies.count, id: \.self) { index in
                  
                  if index >= viewModel.currentIndex {
                     
                     createFlashcardView(for: index)
                        .zIndex(Double(viewModel.showVocabularies.count - index))
                     
                     
                  }
                  
               }
            }
            //.gesture(createDragGesture())
            .padding(.bottom, 90)
            
            
            if viewModel.showMicrophone{
               
                FlashcardMicrophoneModalityView(
                    hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi,
                    responseText: $viewModel.apiResult, showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
                  //audioController.startRecording()
                  
               }
 
               
               /*
                Correct(hanzi: "ABCD", pinyin: "ABCD", meaning: "ABCD", viewModel: viewModel1, showMicrophone: $viewModel.showMicrophone){
                viewModel.performSwipeRight()
                }
                */
               //.frame(height:200)
               
            }
            else if viewModel.checkResult() {
                FlashcardCorrect(viewModel: viewModel1, showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
                  viewModel.performSwipeRight()
               }
            }
            else{
                FlashcardWrong(hanzi: viewModel.showVocabularies[viewModel.currentIndex].hanzi, meaning: viewModel.showVocabularies[viewModel.currentIndex].meaning, viewModel: viewModel1, showMicrophone: $viewModel.showMicrophone, audioController: $audioController){
                  viewModel.performSwipeRight()
               }
            }
            
         }
         .background(.customBeige)
         .ignoresSafeArea(.container, edges: .bottom)
         .overlay{
            FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
         }
         
         FlashcardSidebarButton(viewModel: viewModel){
            tutorialOverlay = tutorialOverlay + 1
         }
         .offset(y: 165)
         
      }
      .overlay{
         if viewModel.showDonePage {
            //FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
            DonePageView()
               .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
               .background(.white)
         }
      }
   }
   
   private func createFlashcardView(for index: Int) -> some View {
      let flashcardView = FlashcardView(vocab: viewModel.showVocabularies[index], width: 300, height: 400)
         .frame(width: 300, height: 400)
      
      // Use AnyView to erase the type and maintain consistency
      var modifiedView: AnyView = AnyView(flashcardView)
      
      if index == viewModel.currentIndex {
         modifiedView = AnyView(modifiedView
            .opacity(1.0)
            .offset(x: viewModel.offset.width)
            .offset(y: viewModel.offset.height * 0.4)
            .rotationEffect(.degrees(viewModel.offset.width / 40.0))
            .animation(.spring(), value: viewModel.offset)
         )
      } else if index == viewModel.currentIndex - 1 {
         modifiedView = AnyView(modifiedView
            .opacity(1.0)
            .offset(x: -300 + viewModel.offset.width)
            .zIndex(Double(viewModel.showVocabularies.count - index))
            .animation(.spring(), value: viewModel.offset)
         )
      }
      
      return modifiedView
   }
   
   private func createDragGesture() -> some Gesture {
      DragGesture()
         .onChanged { gesture in
            viewModel.handleDragChanged(gesture: gesture)
         }
         .onEnded { gesture in
            viewModel.handleDragEnded(gesture: gesture)
         }
   }
}


#Preview {
   FlashcardPageView(viewModel1: StoryViewModel())
}


//#Preview {
//   FlashcardPageView(viewModel1: StoryViewModel())
//}

/*
 struct FlashcardPageView: View {
 @ObservedObject var viewModel1: StoryViewModel
 @StateObject var viewModel = FlashcardViewModel()
 @State var tutorialOverlay: Int = 1
 
 var body: some View {
 ZStack {
 VStack {
 HStack(spacing: 4) {
 Button {
 
 } label: {
 Image(systemName: "xmark")
 .font(.system(size: 32))
 .frame(width: 32, height: 32)
 .foregroundStyle(.orange3)
 }
 Spacer()
 ProgressView(value: viewModel.getProgress())
 .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
 }
 .padding(.horizontal)
 
 Spacer()
 
 ZStack{
 ForEach(0 ..< viewModel.showFlashcards.count, id: \.self) { index in
 
 if index >= viewModel.currentIndex {
 createFlashcardView(for: index)
 .zIndex(Double(viewModel.showFlashcards.count - index))
 .onAppear{
 print(0)
 }
 }
 
 }
 }
 //.gesture(createDragGesture())
 .padding(.bottom, 90)
 
 
 if viewModel.isCheck{
 MicrophoneModalityView()
 .frame(height:200)
 .padding(.top,10)
 }
 else if viewModel.checkResult {
 Correct(hanzi: "ABCD", pinyin: "ABCD", meaning: "ABCD", viewModel: viewModel1){
 viewModel.performSwipeRight()
 }
 }
 else{
 Wrong(hanzi: "ABCD", pinyin: "ABCD", meaning: "ABCD", viewModel: viewModel1){
 viewModel.performSwipeRight()
 }
 }
 
 }
 .background(.customBeige)
 .ignoresSafeArea(.container, edges: .bottom)
 .overlay{
 //FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
 }
 
 FlashcardSidebarButton(){
 tutorialOverlay = tutorialOverlay + 1
 }
 .offset(y: 165)
 
 }
 .overlay{
 if viewModel.showDonePage {
 //FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
 DonePageView()
 .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
 .background(.white)
 }
 }
 }
 
 private func createFlashcardView(for index: Int) -> some View {
 ZStack {
 FlashcardView(vocab: viewModel.showFlashcards[index].meaning, width: 300, height: 400)
 .if(index == viewModel.currentIndex) { view in
 view
 //.opacity(opacity)
 .opacity(1.0)
 .offset(x: viewModel.offset.width)
 .offset(y: viewModel.offset.height * 0.4)
 .rotationEffect(.degrees(viewModel.offset.width / 40.0))
 .animation(.spring(), value: viewModel.offset)
 }
 .if(index == viewModel.currentIndex - 1) { view in
 view
 .opacity(1.0)
 .offset(x: -300 + viewModel.offset.width)
 .zIndex(Double(viewModel.stories[viewModel.currentIndex].flashcard.count - index))
 .animation(.spring(), value: viewModel.offset)
 }
 .onAppear{
 print(1)
 }
 }
 .frame(width: 300, height: 400)
 }
 
 private func createDragGesture() -> some Gesture {
 DragGesture()
 .onChanged { gesture in
 print(2)
 viewModel.handleDragChanged(gesture: gesture)
 }
 .onEnded { gesture in
 print(2)
 viewModel.handleDragEnded(gesture: gesture)
 }
 }
 }
 */







/*
 class FlashcardViewModel: ObservableObject {
 @Published var currentIndex: Int = 0
 @Published var offset: CGSize = .zero
 @Published var checkResult: Bool = false
 @Published var isCheck: Bool = false
 @Published var stories: [Story] = []
 @Published var currentStoryIndex: Int = 0
 @Published var showDonePage: Bool = false
 
 init(){
 loadStories()
 }
 
 func getCurrentStory() -> Story {
 return stories[currentStoryIndex]
 }
 
 func handleDragChanged(gesture: DragGesture.Value) {
 offset = gesture.translation
 }
 
 func handleDragEnded(gesture: DragGesture.Value) {
 if gesture.translation.width < -100, currentIndex > 0 {
 performSwipeLeft()
 } else if gesture.translation.width >= 100, currentIndex < stories[currentIndex].flashcard.count-1 {
 performSwipeRight()
 } else {
 resetCardPosition()
 }
 
 }
 
 func performSwipeLeft() {
 //guard currentIndex > 0 else { return }
 withAnimation(nil) {
 offset = CGSize(width: 500, height: 0)
 currentIndex = max(currentIndex - 1, 0)
 DispatchQueue.main.asyncAfter(deadline: .now()) {
 withAnimation {
 self.offset = .zero
 }
 }
 }
 }
 
 func performSwipeRight() {
 
 guard currentIndex <= getCurrentStory().flashcard.count else {
 return
 }
 
 withAnimation {
 self.offset = CGSize(width: 500, height: 0)
 DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
 self.offset = .zero
 //self.opacity = 1.0
 print("\(self.currentIndex)")
 print("\(self.getCurrentStory().flashcard.count)")
 print("======")
 /*
  if self.currentIndex == self.getCurrentStory().flashcard.count-1 {
  self.currentIndex = 0
  }
  */
 /*
  else if self.currentIndex == self.stories[self.currentIndex].flashcard.count-2{
  //done.toggle()
  self.currentIndex = min(self.currentIndex + 1, self.stories[self.currentIndex].flashcard.count-1 )
  }
  */
 if self.currentIndex == self.getCurrentStory().flashcard.count - 1{
 self.showDonePage = true
 }
 else {
 self.currentIndex = min(self.currentIndex + 1, self.getCurrentStory().flashcard.count-1 )
 }
 }
 }
 }
 
 func resetCardPosition() {
 withAnimation {
 offset = .zero
 }
 }
 
 func loadStories() {
 // Locate the JSON file in the bundle
 guard let url = Bundle.main.url(forResource: "quizpage", withExtension: "json") else {
 print("File not found")
 return
 }
 
 do {
 // Load and decode the JSON data
 let data = try Data(contentsOf: url)
 let decoder = JSONDecoder()
 self.stories = try decoder.decode([Story].self, from: data)
 //print(self.stories)
 } catch {
 print("Failed to decode JSON: \(error.localizedDescription)")
 }
 }
 
 func getProgress() -> Double {
 return Double(currentIndex+1)/Double(stories[currentIndex].flashcard.count)
 }
 }
 */



/*
 struct FlashcardPageView: View {
 @ObservedObject var viewModel1: StoryViewModel
 @StateObject var viewModel = FlashcardViewModel()
 @State var tutorialOverlay: Int = 1
 
 var body: some View {
 ZStack {
 VStack {
 HStack(spacing: 4) {
 Button {
 
 } label: {
 Image(systemName: "xmark")
 .font(.system(size: 32))
 .frame(width: 32, height: 32)
 .foregroundStyle(.orange3)
 }
 Spacer()
 ProgressView(value: viewModel.getProgress())
 .progressViewStyle(CustomProgressViewStyle(height: 8, filledColor: .green2, unfilledColor: .customLightGray))
 }
 .padding(.horizontal)
 
 Spacer()
 
 ZStack{
 ForEach(0 ..< viewModel.getCurrentStory().flashcard.count, id: \.self) { index in
 
 if index >= viewModel.currentIndex {
 
 createFlashcardView(for: index)
 .zIndex(Double(viewModel.stories[viewModel.currentIndex].flashcard.count - index))
 .onAppear{
 print(0)
 }
 
 }
 }
 }
 //.gesture(createDragGesture())
 .padding(.bottom, 90)
 
 
 if viewModel.isCheck{
 
 }
 else if viewModel.checkResult {
 Correct(hanzi: "ABCD", pinyin: "ABCD", meaning: "ABCD", viewModel: viewModel1){
 viewModel.performSwipeRight()
 }
 }
 else{
 Wrong(hanzi: "ABCD", pinyin: "ABCD", meaning: "ABCD", viewModel: viewModel1){
 viewModel.performSwipeRight()
 }
 }
 
 }
 .background(.customBeige)
 .ignoresSafeArea(.container, edges: .bottom)
 .overlay{
 //FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
 }
 
 FlashcardSidebarButton(){
 tutorialOverlay = tutorialOverlay + 1
 }
 .offset(y: 165)
 
 }
 .overlay{
 if viewModel.showDonePage {
 //FlashcardTutorialOverlay(tutorialOverlay: $tutorialOverlay)
 PinyinPageView()
 }
 }
 }
 
 private func createFlashcardView(for index: Int) -> some View {
 ZStack {
 FlashcardView(vocab: viewModel.getCurrentStory().flashcard[index], width: 300, height: 400)
 .if(index == viewModel.currentIndex) { view in
 view
 //.opacity(opacity)
 .opacity(1.0)
 .offset(x: viewModel.offset.width)
 .offset(y: viewModel.offset.height * 0.4)
 .rotationEffect(.degrees(viewModel.offset.width / 40.0))
 .animation(.spring(), value: viewModel.offset)
 }
 .if(index == viewModel.currentIndex - 1) { view in
 view
 .opacity(1.0)
 .offset(x: -300 + viewModel.offset.width)
 .zIndex(Double(viewModel.stories[viewModel.currentIndex].flashcard.count - index))
 .animation(.spring(), value: viewModel.offset)
 }
 .onAppear{
 print(1)
 }
 
 }
 .frame(width: 300, height: 400)
 }
 
 private func createDragGesture() -> some Gesture {
 DragGesture()
 .onChanged { gesture in
 print(2)
 viewModel.handleDragChanged(gesture: gesture)
 }
 .onEnded { gesture in
 print(2)
 viewModel.handleDragEnded(gesture: gesture)
 }
 }
 }
 
 
 */

