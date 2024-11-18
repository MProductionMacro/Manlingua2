//
//  ImportantNotesPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct ImportantNotesPageView : View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var router: Router
    //@StateObject var viewModel = ImportantNotesViewModel()
    @EnvironmentObject var viewModel : ImportantNotesViewModel
    var displayMode : NoteDisplayMode
    
    var body : some View{
        VStack{
            Text("Catatan Penting")
                .font(Font.titleKe2())
                .padding(.top, 16)
                .padding(.bottom,-2)
            
            if viewModel.getNotes().isEmpty {
               Spacer()
               VStack(alignment: .center){
                   Image(.orangeForBlank)
                       .resizable()
                       .frame(width: 158, height: 161)
                       .padding(.bottom, 36)
                        
                   Text("Ayo simpan kata yang ingin")
                       .font(.judulBiasa())
                       .foregroundColor(.emptyListText)
                       .opacity(colorScheme == .light ? 1 : 0.7)
                   
                   Text("kamu pelajari kembali")
                       .font(.judulBiasa())
                       .foregroundColor(.emptyListText)
                       .opacity(colorScheme == .light ? 1 : 0.7)

               }
               Spacer()
//               Spacer()
            }
            else{
                ScrollView{
                    VStack (spacing: 32){
                        ForEach(viewModel.getNotes(), id: \.self){ note in
                            NotesCardView(note: note)
                        }
                        if viewModel.notes.count == 0 {
                            Text("No notes found.")
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)

                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, UIScreen.main.bounds.height < 700 ? -50 : 8)
        .frame(maxWidth: .infinity)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(alignment: .top){
                    Button(action:{
                        if displayMode == .favorite{
                            router.popToRoot()
                        }
                        else{
                            router.pop()
                        }
                    }){
                        Image(systemName: "chevron.left")
                            .foregroundColor(.orangeDarkMode)
                            .font(.title3)
                            .bold()
                        
                        Text("Kembali")
                            .foregroundColor(.orangeDarkMode)
                            .bold()
                    }
                }
            }
        }
        .onAppear{
            //viewModel.loadNoteData(storyId: 1, subChapterId: 1)
            viewModel.loadNotes(from: displayMode)
        }
        .navigationBarBackButtonHidden(true)
        .background(.blankBackground)
    }
}

#Preview{
    NavigationView{
        //ImportantNotesPageView(displayMode: .subChapter(storyId: 1, subChapterId: 1))
        ImportantNotesPageView(displayMode : .subChapter(storyId: 1, subChapterId: 1))
    }
    .environmentObject(Router())
    .environmentObject(ImportantNotesViewModel())
}
