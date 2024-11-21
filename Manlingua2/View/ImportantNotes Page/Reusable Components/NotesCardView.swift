//
//  NotesCardView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct NotesCardView : View{
   var note: ImportantNote
   @State var isBookmarked = false
   @EnvironmentObject var viewModel: ImportantNotesViewModel

    var body : some View {
        VStack{
            Button(action:{
                if isBookmarked{
                    SwiftDataServices.shared.deleteNote(note)
                }
                else{
                    viewModel.addNotes(note)
                }
                isBookmarked.toggle()
            }, label: {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.titleKe2())
                    .foregroundStyle(.orangeDarkMode)
                    .frame(width: 295, alignment: .trailing)
                    .padding(.bottom, 8)
            })
            //.frame(width: 138, alignment: .trailing)
            
            Text(note.title)
                .font(Font.bold24())
                .padding(.bottom, 16)
            
            VStack(spacing: 16){
                HStack(alignment: .top, spacing: 16){
                    Image("Do")
                        .resizable()
                        .frame(width: 38, height: 38)
                    VStack(alignment: .leading){
                        Text("Boleh Dilakukan:".localized)
                            .font(.system(size: 14, weight: .bold))
                        Text(note.allowed)
                            .font(.system(size: 14, weight: .regular))
                        
                    }
                    //.frame(width: 252, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal, 24)
                
                HStack(alignment: .top, spacing: 16){
                    Image("Dont")
                        .resizable()
                        .frame(width: 38, height: 38)
                    VStack(alignment: .leading){
                        Text("Tidak Boleh Dilakukan:".localized)
                            .font(.system(size: 14, weight: .bold))
                        Text(note.forbidden)
                            .font(.system(size: 14, weight: .regular))
                        
                    }
                    //.frame(width: 252, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal, 24)

                
                HStack(alignment: .top, spacing: 16){
                    Image("Warning")
                        .resizable()
                        .frame(width: 38, height: 38)
                    VStack(alignment: .leading){
                        Text("Harus Berhati-hati:".localized)
                            .font(.system(size: 14, weight: .bold))
                        Text(note.caution)
                            .font(.system(size: 14, weight: .regular))
                        
                    }
                    //.frame(width: 252, alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal, 24)

            }
            .padding(.bottom, 32)
        }
        //.frame(width : (UIScreen.main.bounds.height < 700 ? 339 : 359))
        .frame(maxWidth: .infinity)
        .background(.cardBackground)
        .cornerRadius(17)
        .shadow(color: .cardShadow.opacity(0.2), radius: 12, x: 0, y: 0)
        .onAppear{
            isBookmarked = SwiftDataServices.shared.isNoteExist(note)
        }
    }
}

#Preview{
   NotesCardView(note : ImportantNote(title: "Perkenalan Nama", allowed: "Gunakan sapaan formal “您好” (Nín hǎo), perkenalkan diri dan posisi, ungkapkan minat kerjasama.", forbidden: "Jangan langsung pakai panggilan informal & masuk ke bisnis.", caution: "Perhatikan bahasa tubuh, jaga sikap tetap ramah.", language: "en"))
}
