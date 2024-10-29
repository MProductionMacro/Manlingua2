//
//  ProfilePageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 15/10/24.
//

import SwiftUI
import Charts

struct ProfilePageView: View {
   @StateObject var viewModel = ProfileViewModel()
   
   var body: some View {
      VStack(alignment: .leading){
         HStack{
            Image("ProfilePicture")
               .resizable()
               .frame(width: 83.5, height: 83.5)
               .padding(.trailing, 5)
            VStack(alignment: .leading){
               Text("\(viewModel.getName())")
                  .font(Font.judulBesar())
                  .foregroundColor(.white)
                  .padding(.bottom, 1)
               Text("\(viewModel.getLevel())")
                  .font(Font.subJudul())
                  .padding(.top, 1)
            }
         }
         .padding(.horizontal, 16)
         .padding(.bottom, 17)
         .padding(.top, 30)
         
         VStack(spacing: 32){
            VStack(alignment: .leading, spacing: 20){
               Text("Penilaian")
                  .font(Font.judulBiasa())
                  .frame(width: 321, alignment: .leading)
               
               Chart(viewModel.datas, id: \.self){ data in
                  BarMark(
                     x: .value("Item", data.name),
                     y: .value("Units Sold", data.value)
                  )
                  .foregroundStyle(.green)
               }
               .frame(width: 300, height: 169)
               
            }
            .padding(.top, 32)
            
            VStack(spacing: 24){
               ProfileNavigationButton(title: "Languages", imageName: "globe"){
                  
               }
               .frame(width: 321, height: 35)
               
               
               ProfileNavigationButton(title: "Notification", imageName: "bell"){
                  
               }
               .frame(width: 321, height: 35)
               
               ProfileNavigationButton(title: "IoT", imageName: "externaldrive.connected.to.line.below"){
                  
               }
               .frame(width: 321, height: 35)
               
               ProfileNavigationButton(title: "Widget", imageName: "square.on.square"){
                  
               }
               .frame(width: 321, height: 35)
            }
            .frame(width: 321)
            
            Spacer()
         }
         .frame(width: 401, height: 600)
         .background(.white)
         .clipShape(CustomRoundedRectangle(cornerRadius: 32, corners: [.topLeft, .topRight]))
         
         Spacer()
      }
      .edgesIgnoringSafeArea(.bottom)
      .background(Image("ProfilePage"))
   }
}

#Preview {
   ProfilePageView()
}


