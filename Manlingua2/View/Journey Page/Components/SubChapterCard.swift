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
    @StateObject var singleton = UserDefaultSingleton.shared

   
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

                VStack(alignment: .leading) {
                    Text("Bagian \(subChapter.id)")
                        .font(.title3)
                    Text(subChapter.title)
                        .font(Font.subJudul())
                        .fontWeight(.bold)
                    Text(subChapter.pinyin)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.gray)
                    Text(subChapter.hanzi)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.customBlack)
                    HStack{
                        Image(systemName: "clock.fill")
                            .foregroundStyle(.gray)
                        Text("sekitar 10 menit")
                            .foregroundStyle(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color(.black))
         
            Image(systemName: isLocked ? "lock" : "chevron.right")
                .foregroundStyle(.gray)
                .fontWeight(.bold)

            Spacer()
        }
        .frame(width: 340)
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
