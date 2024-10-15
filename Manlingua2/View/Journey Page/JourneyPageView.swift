//
//  JourneyPageView.swift
//  Manlingua2
//
//  Created by Christine Putri on 14/10/24.
//

import SwiftUI

struct JourneyPageView: View {
    //TODO: Font Tolong diperbaiki sesuai figma, Asset tolong di import sesuai figma
    
    var judul: String = "Perkenalan"
    var pinyin: String = "jiè shào"
    var hanzi: String = "介绍"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                Text("\(judul)")
                    .font(Font.titleKe2())
                    .foregroundStyle(.white)
                    .padding(.top, 2)
                Text("\(pinyin)")
                    .font(Font.normalText())
                    .foregroundStyle(.white)
                Text("\(hanzi)")
                    .font(Font.judulBiasa())
                    .foregroundStyle(.white)
                HStack {
                    RectangleButton(labelImage: .diceFive, label: "List Kata-Kata",backgroundColor: .gold2 ,buttonSize: .small,fontSytle: Font.subJudul(),screen: .dictionary)
                        .padding(.top, 2)
                }
            }
            .padding()
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 32))
                    .frame(maxHeight: .infinity)
                
                ZStack {
                    // List of Chapters
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 24) {
                            HStack{
                                Text("Pengantar")
                                    .font(Font.judulBiasa())
                                Spacer()
                            }
                            Text("Nama saya Abai. Bisakah saya memperkenalkan diri, ngobrol ringan, dan membangun hubungan bisnis yang kuat dengan mitra Tiongkok? Yuk, kita pelajari caranya bersama!")
                                .font(.normalText())
                                .padding()
//                                .background(.white) //hapus
                                .overlay(RoundedRectangle(cornerRadius: 16).stroke(.customLightGray, lineWidth: 1)) //Black ganti warna
                            HStack{
                                Text("Sub-bab")
                                    .font(Font.judulBiasa())
                                Spacer()
                            }
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: 24) {
                                    //TODO: ForEach pake json
                                    SubChapterCard(labelImage: .haidilaoChapter, chapter: "Bagian 1", title: "Perkenalan Nama", pinyin: "zì wǒ jiè shào", hanzi: "自 我 介 绍" ,isLocked: false)
                                    SubChapterCard(labelImage: .haidilaoChapter, chapter: "Bagian 2", title: "Obrolan Ringan", pinyin: "xián liáo", hanzi: "闲 聊",isLocked: true)
                                    SubChapterCard(labelImage: .haidilaoChapter, chapter: "Bagian 3", title: "Minum Teh", pinyin: "hē chá", hanzi: "喝 茶",isLocked: true)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 36)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Image(.homeBackground)
                .ignoresSafeArea()
        )
    }
}
#Preview {
    JourneyPageView()
}
