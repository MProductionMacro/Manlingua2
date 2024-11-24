//
//  CameraGrantedView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 30/10/24.
//

import SwiftUI

struct CameraGrantedView: View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ChallengeViewModel
   @StateObject var cameraController = CameraController.shared
   
   @State var image: UIImage = UIImage(resource: .placeholderChallenge)
   @State var isShowingMeaning = false
   @State var isCorrect = false
   @State var objects: [Object] = []
   
   @Binding var isShowingCamera: Bool
   @Binding var isPredicted: Bool
   @Binding var isLoading: Bool
   
   var body: some View {
      ZStack {
         ScrollView {
            VStack(spacing: 24) {
               VStack(alignment: .leading, spacing: 8) {
                  Text("Cari dan fotokan".localized)
                     .font(.judulBiasa())
                  
                  VStack(alignment: .leading) {
                     Text(objects.first?.pinyin ?? "Pinyin")
                        .font(.pinyin())
                        .foregroundStyle(.gray)
                     Text(objects.first?.hanzi ?? "Hanzi")
                        .font(.hanzi())
                        .overlay {
                           DottedUnderline()
                              .frame(height: UIScreen.main.bounds.height * 0.015)
                              .offset(y: UIScreen.main.bounds.height * 0.02)
                        }
                        .onTapGesture {
                           isShowingMeaning.toggle()
                        }
                        .popover(isPresented: $isShowingMeaning) {
                           Text(objects.first?.meaning ?? "Meaning")
                              .font(.hanzi())
                              .foregroundColor(.black)
                              .padding()
                              .background(Color.customLightGray)
                              .cornerRadius(8)
                              .presentationCompactAdaptation(.popover)
                        }
                  }
               }
               .frame(maxWidth: .infinity, alignment: .leading)
               
               Button {
                  isShowingCamera = true
               } label: {
                  Image(systemName: "camera.fill")
                     .font(.system(size: 32))
                     .padding(8)
               }
               .buttonStyle(CircleButton())
               
               Button {
                  objects = viewModel.objects_example.shuffled()
               } label: {
                  Text("Lewati".localized)
                     .frame(maxWidth: .infinity)
               }
               .buttonStyle(SecondaryButton(isDisabled: false))
            }
         }
         .padding(.horizontal)
         .padding(.top, 32)
         .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
         .background(Color.blankBackground)
         .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
         .ignoresSafeArea()
         .onAppear {
            objects = viewModel.objects_example.shuffled()
         }
         .overlay {
            if viewModel.isPredicted {
               CorrectOrWrong(
                  isSpeakingQuestion: .constant(false),
                  hanzi: objects.first?.hanzi ?? "",
                  pinyin: objects.first?.pinyin ?? "",
                  meaning: objects.first?.meaning ?? "",
                  isCorrect: isCorrect,
                  type: .cameraQuestion
               ) {
                  withAnimation{
                     viewModel.isPredicted = false
                     objects = viewModel.objects_example.shuffled()
                  }
               } tryAgainFunc: {
                  withAnimation{
                     viewModel.isPredicted = false
                  }
               }
               .frame(maxHeight: .infinity, alignment: .bottom)
               .ignoresSafeArea()
               .transition(.move(edge: .bottom))
               .onAppear {
                  isLoading = false
               }
            }else{
               EmptyView()
            }
         }
         .animation(.easeInOut, value: isShowingCamera)
         .onChange(of: viewModel.predictions) { oldValue, newValue in
            withAnimation {
               guard !viewModel.predictions.isEmpty else {
                  print("No predictions available")
                  isCorrect = false // Mark as incorrect if no predictions are available
                  return
               }
               
               let matchingPredictions = viewModel.predictions.filter { prediction in
                  prediction.class == objects.first?.meaning
               }
               
               // Check if there are any matches
               isCorrect = !matchingPredictions.isEmpty
               print("Matching Predictions: \(matchingPredictions)")
            }
         }
      }
   }
}


//#Preview {
//   CameraGrantedView()
//      .environmentObject(Router())
//      .environmentObject(ChallengeViewModel())
//}
