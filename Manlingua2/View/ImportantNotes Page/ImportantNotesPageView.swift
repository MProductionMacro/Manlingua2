//
//  ImportantNotesPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct ImportantNotesPageView : View {
   @EnvironmentObject var router: Router
   @EnvironmentObject var viewModel: ImportantNotesViewModel
   var displayMode : NoteDisplayMode
   
   var body : some View{
      VStack{
         Text("Catatan Penting")
            .font(Font.titleKe2())
            .padding(.top, 16)
            .padding(.bottom,-2)
         
         ScrollView{
            VStack (spacing: 32){
               ForEach(viewModel.getNotes(displayMode), id: \.self){ note in
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
      .toolbar {
         ToolbarItem(placement: .topBarLeading) {
            HStack(alignment: .top){
               Button(action:{
                  router.pop()
               }){
                  Image(systemName: "chevron.left")
                     .foregroundColor(.orange3)
                     .font(.title3)
                     .bold()
                  
                  Text("Kembali")
                     .foregroundColor(.orange3)
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
      /*
       .navigationBarItems(leading: Button(action: {
       router.pop()
       }) {
       HStack {
       Image(systemName: "chevron.left")
       Text("Kembali")
       }
       .foregroundColor(.orange)
       })
       */
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
