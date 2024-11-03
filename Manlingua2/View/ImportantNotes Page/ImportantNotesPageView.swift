//
//  ImportantNotesPageView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 02/11/24.
//

import SwiftUI

struct ImportantNotesPageView : View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel = ImportantNotesViewModel()

    var body : some View{
        VStack{
            Text("Catatan Penting")
                .font(Font.titleKe2())
                .padding(.top, 16)
                .padding(.bottom,-2)
            
            ScrollView{
                VStack (spacing: 32){
                    ForEach(viewModel.getImportantNotes(), id:\.self){ note in
                        NotesCardView(note: note)
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
    }
}

#Preview{
    NavigationView{
        ImportantNotesPageView()
    }
    .environmentObject(Router())
}
