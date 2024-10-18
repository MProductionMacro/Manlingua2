//
//  FlashcardSwipeView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 07/10/24.
//
/*
import SwiftUI

struct FlashcardSwipeView: View {
   @Binding var isShowingFlashcard: Bool
   @State private var isShowingConfirmation: Bool = false
   @State private var isShowingDict: Bool = false
   @ObservedObject var viewModel: StoryViewModel
   @State private var currentIndex: Int = 0
   @State private var offset: CGSize = .zero
   @State private var opacity: Double = 1.0
   @State private var done: Bool = false
   @ObservedObject var homeViewModel: HomeViewModel
   
   var body: some View {
      ZStack {
         VStack {
            ZStack {
               VStack {
                  ZStack {
                     if isShowingConfirmation {
                        Color.black.opacity(0.4)
                           .edgesIgnoringSafeArea(.all)
                        
                        ConfirmationView(isShowingConfirmation: $isShowingConfirmation, homeVM: homeViewModel)
                           .frame(width: 1000, height: 1000)
                           .transition(.scale)
                           .zIndex(5)
                           .padding(.bottom, 85)
                     }
                     else{
                        ForEach(0 ..< viewModel.currentStory.flashcard.count, id: \.self) { index in
                           if index >= currentIndex {
                              createFlashcardView(for: index)
                                 .zIndex(Double(viewModel.currentStory.flashcard.count - index))
                           }
                            
                        }
                     }
                     VStack {
                        HStack (alignment: .top) {
                           BackButton(isShowingConfirmation: $isShowingConfirmation, isShowingDict: $isShowingDict)
                              .position(x:6,y:-8)
                           Spacer()
                        }
                        .frame(height:20)
                        .padding()
                        Spacer()
                     }
                     .frame(alignment: .top)
                     .padding()
                     
                     ZStack {
                        VStack {
                           Spacer()
                           HStack {
                              if currentIndex > 0 {
                                 PreviousButton(action: {
                                    performSwipeLeft()
                                 })
                              }
                              Spacer()
                              NextButton(action: {
                                 performSwipeRight()
                              })
                           }
                        }
                        .frame(maxHeight: 500)
                        
                     }
                     
                     
                  }
                  
                  
               }
            }
            .gesture(createDragGesture())
            
            //                .contentShape(Rectangle())
            if done {
               Button(action: {
                  viewModel.moveToNextStage()
                  //                        homeViewModel.switchStage(to: .home)
               }) {
                  HStack {
                     Text("I'm Ready!")
                        .foregroundColor(.white)
                        .padding()
                        .font(.system(size: 20, weight: .bold))
                  }
                  .frame(width: 300)
                  .background(.orange3)
                  .clipShape(RoundedRectangle(cornerRadius: 16))
                  .overlay(
                     RoundedRectangle(cornerRadius: 16)
                        .stroke(.orange3, lineWidth: 1)
                        .frame(width: 300)
                  )
               }
               .padding(.bottom, 80)
            }
         }
         .padding()
         .background(Image(viewModel.currentStory.background))
      }
   }
   
   // MARK: - Helper Methods
   
   private func createFlashcardView(for index: Int) -> some View {
      ZStack {
         FlashcardView(vocab: viewModel.currentStory.flashcard[index], width: 300, height: 400)
            .if(index == currentIndex) { view in
               view
                  .opacity(opacity)
                  .offset(x: offset.width)
                  .offset(y: offset.height * 0.4)
                  .rotationEffect(.degrees(offset.width / 40.0))
                  .animation(.spring(), value: offset)
            }
            .if(index == currentIndex - 1) { view in
               view
                  .opacity(1.0)
                  .offset(x: -300 + offset.width)
                  .zIndex(Double(viewModel.currentStory.flashcard.count - index))
                  .animation(.spring(), value: offset)
            }
         
         SoundButtonView(vocab: viewModel.currentStory.flashcard[index])
            .frame(width: 30, height: 30)
            .offset(x: 36, y: 130)
      }
      .frame(width: 300, height: 400)
   }
   
   private func createDragGesture() -> some Gesture {
      DragGesture()
         .onChanged { gesture in
            handleDragChanged(gesture: gesture)
         }
         .onEnded { gesture in
            handleDragEnded(gesture: gesture)
         }
   }
   
   private func handleDragChanged(gesture: DragGesture.Value) {
      offset = gesture.translation
      opacity = (abs(gesture.translation.width) > 100) ? 0.8 : 1.0
   }
   
   private func handleDragEnded(gesture: DragGesture.Value) {
      if gesture.translation.width < -100, currentIndex > 0 {
         performSwipeLeft()
      } else if gesture.translation.width >= 100 {
         performSwipeRight()
      } else {
         resetCardPosition()
      }
   }
   
   private func performSwipeLeft() {
      guard currentIndex > 0 else { return }
      withAnimation(nil) {
         offset = CGSize(width: 500, height: 0)
         currentIndex = max(currentIndex - 1, 0)
         DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation {
               offset = .zero
            }
         }
      }
   }
   
   private func performSwipeRight() {
      withAnimation {
         offset = CGSize(width: 500, height: 0)
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            offset = .zero
            opacity = 1.0
            if currentIndex == viewModel.currentStory.flashcard.count - 1 {
               currentIndex = 0
            } else if currentIndex == viewModel.currentStory.flashcard.count - 2 {
               done.toggle()
               currentIndex = min(currentIndex + 1, viewModel.currentStory.flashcard.count - 1)
            } else {
               currentIndex = min(currentIndex + 1, viewModel.currentStory.flashcard.count - 1)
            }
         }
      }
   }
   
   private func resetCardPosition() {
      withAnimation {
         offset = .zero
         opacity = 1.0
      }
   }
}

#Preview {
   FlashcardSwipeView(isShowingFlashcard: .constant(false), viewModel: StoryViewModel(), homeViewModel: HomeViewModel())
}

extension View {
   func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
      condition ? AnyView(transform(self)) : AnyView(self)
   }
}
*/

/*
import SwiftUI

struct FlashcardView: View {
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
      //            .shadow(radius: 1.5)
      //            .overlay(
      //                SoundButton(vocab: vocab)
      //                    .frame(width: 30, height: 30)
      //                    .padding(.top, height * 0.65)
      //                    .padding(.leading, width * 0.24)
      //            )
   }
}

#Preview {
   FlashcardView(vocab: "谢谢", width: 300, height: 400)
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
                    ForEach(0 ..< viewModel.stories[viewModel.currentIndex].flashcard.count, id: \.self) { index in
            
                        if index >= viewModel.currentIndex {
        
                            createFlashcardView(for: index)
                                .zIndex(Double(viewModel.stories[viewModel.currentIndex].flashcard.count - index))
                                .onAppear{
                                    print(0)
                                }
                            
                        }
                    }
                }
                .gesture(createDragGesture())
                .padding(.bottom, 90)
                
                
                if viewModel.isCheck{
                    
                }
                else if viewModel.checkResult {
                    Correct(hanzi: "ABCD", pinyin: "ABCD", meaning: "ABCD", viewModel: viewModel1)
                }
                else{
                    Wrong(hanzi: "ABCD", pinyin: "ABCD", meaning: "ABCD", viewModel: viewModel1)
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
        
    }
   
    private func createFlashcardView(for index: Int) -> some View {
        ZStack {
            FlashcardView(vocab: viewModel.stories[viewModel.currentIndex].flashcard[index], width: 300, height: 400)
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
