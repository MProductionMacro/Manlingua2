//
//  StoryView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 27/09/24.
//

import SwiftUI

struct StoryListView: View {
   @ObservedObject var homeViewModel: HomeViewModel
   @ObservedObject var viewModel: StoryViewModel
   
   var body: some View {
      //      TODO: Beberapa size masih hard coded
      VStack(spacing: 0) {
         VStack(alignment: .leading) {
            Text("Cerita seru apa yang ingin kamu")
               .fontWeight(.semibold)
               .foregroundStyle(.white)
            Text("Coba Jelajah?")
               .font(.judulBesar())
               .foregroundStyle(.white)
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .padding(.leading, 20)
         .padding(.top)
         .padding(.bottom, 27)
         
         //         ZStack {
         //            Rectangle()
         //               .fill(.white)
         //               .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft]))
         
         VStack(spacing: 32) {
            ScrollView {
               HomeCardScrollView(homeViewModel: homeViewModel, viewModel: viewModel)
               
               //MARK: Reusable component
               VStack(alignment: .leading, spacing: 0) {
                  Text("Kata-kata")
                     .font(.judulBiasa())
                     .padding(.leading, 24)
                  
                  ScrollView(.horizontal, showsIndicators: false){
                     HStack(spacing: 24) {
                        //MARK: Reusable component
                        Button {
                           
                        } label: {
                           VStack {
                              VStack {
                                 Text("Harian")
                                    .font(.subJudul())
                                    .foregroundStyle(.black)
                                 
                                 Image(.calendarStory)
                              }
                              .padding(.horizontal, 34)
                              .padding(.vertical)
                           }
                           .background(.white)
                           .clipShape(.rect(cornerRadius: 16))
                           .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
                           .padding(.vertical)
                           .padding(.leading, 24)
                        }
                        
                        Button {
                           
                        } label: {
                           VStack {
                              VStack {
                                 Text("Favorit")
                                    .font(.subJudul())
                                    .foregroundStyle(.black)
                                 
                                 Image(.favoriteStory)
                              }
                              .padding(.horizontal, 34)
                              .padding(.vertical)
                              .background(.white)
                              .clipShape(.rect(cornerRadius: 16))
                              .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
                           }
                        }
                        
                        Button {
                           
                        } label: {
                           VStack {
                              VStack {
                                 Text("Catatan")
                                    .font(.subJudul())
                                    .foregroundStyle(.black)
                                 
                                 Image(.noteStory)
                              }
                              .padding(.horizontal, 34)
                              .padding(.vertical)
                           }
                           .background(.white)
                           .clipShape(.rect(cornerRadius: 16))
                           .shadow(color: Color(red: 0.42, green: 0.21, blue: 0).opacity(0.2), radius: 9, x: 0, y: 0)
                        }
                        
                     }
                  }
               }
               .frame(maxWidth: .infinity, alignment: .leading)
//               .padding(.leading, 24)
               .padding(.bottom, 48)
            }
            .padding(.bottom, 48)
            .ignoresSafeArea()
         }
         .background(.white)
      }
      .background(Image(.homeBackground))
   }
}

#Preview {
   StoryListView(homeViewModel: HomeViewModel(), viewModel: StoryViewModel())
}
