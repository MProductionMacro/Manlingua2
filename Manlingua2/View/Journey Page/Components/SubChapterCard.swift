//
//  SubChapterCard.swift
//  Manlingua2
//
//  Created by Christine Putri on 15/10/24.
//
import SwiftUI

struct SubChapterCard: View {
   @State var labelImage: ImageResource
   @State var isLocked:Bool
   var id: Int
   var subChapter: SubChapter_Example
   
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: StoryViewModel
   @EnvironmentObject var homeVM: HomeViewModel
   @StateObject var singleton = CoreDataSingleton.shared
   
   var body: some View {
      HStack {
         HStack(spacing: 12) {
            if isLocked {
               Image("LockChapter")
                  .resizable()
                  .frame(width: 86, height: 86)
            }
            else{
               Image("HaidilaoChapter")
                  .resizable()
                  .frame(width: 86, height: 86)
            }
            
            VStack(alignment: .leading, spacing: 4) {
               Text("Bagian \(subChapter.id)")
                  .font(.pinyin())
                  .fontWeight(.bold)
               Text(subChapter.title)
                  .font(.subJudul())
               VStack(spacing: 0){
                  Text(subChapter.pinyin)
                     .multilineTextAlignment(.leading)
                     .font(.pinyin())
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .foregroundStyle(.lightDarkGrey)
                  Text(subChapter.hanzi)
                     .multilineTextAlignment(.leading)
                     .font(.hanzi())
                     .frame(maxWidth: .infinity, alignment: .leading)
                     .foregroundStyle(.lightDarkGrey)
               }
               
               HStack(spacing: 2){
                  Image(systemName: "clock")
                     .foregroundStyle(.lightDarkGrey)
                     .font(.normalText())
                  
                  Text("sekitar 10 menit")
                     .foregroundStyle(.lightDarkGrey)
                     .font(.pinyin())
               }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
         }
         .frame(maxWidth: .infinity, alignment: .leading)
         .foregroundStyle(Color(.black))
         
         Image(systemName: isLocked ? "lock" : "chevron.right")
            .foregroundStyle(isLocked ? .gray : .orange3)
         
         Spacer()
      }
//      .frame(width: 340)
      .padding()
      .overlay(
         RoundedRectangle(cornerRadius: 20)
            .stroke(.customLightGray, lineWidth: 1)
      )
   }
}
//
//#Preview {
//   SubChapterCard(labelImage: .haidilaoChapter, chapter: "Bagian 1", title: "Perkenalan", pinyin: "jiè shào", hanzi: "介 绍",isLocked: true, id: 1, subChapterId: 1)
//      .environmentObject(Router())
//      .environmentObject(StoryViewModel())
//      .environmentObject(HomeViewModel())
//}
