//
//  NotesCardView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct NotesCardView : View{
    
    var note: ImportantNote
    
    var body : some View {
        VStack{
            Image(systemName: "bookmark")
                .font(.titleKe2())
                .foregroundStyle(.orange3)
                .frame(width: 295, alignment: .trailing)
                .padding(.bottom, 8)
            
            Text(note.title)
                .font(Font.bold24())
                .padding(.bottom, 16)
            
            VStack(spacing: 16){
                HStack(alignment: .top, spacing: 8){
                    Image("Do")
                        .resizable()
                        .frame(width: 38, height: 38)
                    VStack(alignment: .leading){
                        Text("Boleh Dilakukan:")
                            .font(.system(size: 14, weight: .bold))
                        Text(note.allowed)
                            .font(.system(size: 14, weight: .regular))
                        
                    }
                    .frame(width: 252, alignment: .leading)
                }
                
                HStack(alignment: .top, spacing: 8){
                    Image("Dont")
                        .resizable()
                        .frame(width: 38, height: 38)
                    VStack(alignment: .leading){
                        Text("Tidak Boleh Dilakukan:")
                            .font(.system(size: 14, weight: .bold))
                        Text(note.forbidden)
                            .font(.system(size: 14, weight: .regular))
                        
                    }
                    .frame(width: 252, alignment: .leading)
                }
                
                HStack(alignment: .top, spacing: 8){
                    Image("Warning")
                        .resizable()
                        .frame(width: 38, height: 38)
                    VStack(alignment: .leading){
                        Text("Harus Berhati-hati:")
                            .font(.system(size: 14, weight: .bold))
                        Text(note.caution)
                            .font(.system(size: 14, weight: .regular))
                        
                    }
                    .frame(width: 252, alignment: .leading)
                    
                }
            }
            .padding(.bottom, 32)
        }
        .frame(width: 359)
        .background(.white)
        .cornerRadius(17)
        .shadow(color: .black.opacity(0.2), radius: 12, x: 0, y: 0)
    }
}


#Preview{
    NotesCardView(note : ImportantNote(title: "Perkenalan Nama", allowed: "Gunakan sapaan formal “您好” (Nín hǎo), perkenalkan diri dan posisi, ungkapkan minat kerjasama.", forbidden: "Jangan langsung pakai panggilan informal & masuk ke bisnis.", caution: "Perhatikan bahasa tubuh, jaga sikap tetap ramah.", language: "en"))
}
