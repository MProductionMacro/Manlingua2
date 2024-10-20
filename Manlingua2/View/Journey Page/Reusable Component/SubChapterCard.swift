//
//  SubChapterCard.swift
//  Manlingua2
//
//  Created by Christine Putri on 15/10/24.
//
import SwiftUI

struct SubChapterCard: View {
    @State var labelImage: ImageResource
    @State var chapter : String
    @State var title:String
    @State var pinyin:String
    @State var hanzi:String
    @State var isLocked:Bool
    
    var body: some View {
        HStack() {
            HStack(spacing: 12) {
                Image(labelImage)
                    .resizable()
                    .frame(width: 86, height: 86)
                VStack(alignment: .leading) {
                    Text(chapter)
                        .font(.title3)
                    Text(title)
                        .font(Font.subJudul())
                        .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                    Text(pinyin)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.gray)
                    Text(hanzi)
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
            if isLocked{
                Image(systemName: "lock")
                    .foregroundStyle(.gray)
                    .fontWeight(.bold)
            }
            else{
                Image(systemName: "chevron.right")
                    .foregroundStyle(.orange)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .frame(width: 340)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.customLightGray, lineWidth: 1)
        )
//        .background(.red) //hapus
    }
}

#Preview {
    SubChapterCard(labelImage: .haidilaoChapter, chapter: "Bagian 1", title: "Perkenalan", pinyin: "jiè shào", hanzi: "介 绍",isLocked: true)
}
