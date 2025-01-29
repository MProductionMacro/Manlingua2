//
//  ChangeNameView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 24/11/24.
//

import SwiftUI

struct ChangeNameView : View{
    @EnvironmentObject private var router: Router
    @State private var editText: String = ""
    @State private var characters: Int = 10
    @StateObject private var swiftDataServices = SwiftDataServices.shared
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 16){
                Text("Nama".localized)
                    .font(.heavy32())
                
                Text("Aplikasi akan menampilkan nama yang Anda tuliskan dibawah".localized)
                    .font(.subJudul())
                    .opacity(0.65)
                
                
                ZStack(alignment: .center){
                    TextField("\(swiftDataServices.username)", text: $editText)
                        .font(Font.normal16())
                        .foregroundStyle(.fontColors)
                        .frame(maxWidth: .infinity)
                        .padding(.leading, 16)
                        .onChange(of: editText) {
                            characters = 20 - editText.count
                        }
                    
                    Text("\(characters)")
                        .foregroundStyle(characters >= 0 ? .detailIoTText : .red)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 16)

                }
                //.frame(width: 357, height: 44, alignment: .leading)
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                //.padding(.horizontal, 16)
                .background(.detailIoTSelectedContainer)
                //.background(.detailIoTSelectedContainer)
                .cornerRadius(10)
                .shadow(color: .cardShadow.opacity(0.15), radius: 5, x: 0, y: 0)
                
                
                Spacer()
                
                Button(action: {
                    if characters >= 0 {
                        swiftDataServices.updateUsername(newName: editText)
                    }
                }) {
                    Text("Simpan".localized)
                      .foregroundStyle(Color.white)
                      .font(.button())
                      .padding(20)
                      .frame(maxWidth: .infinity)
                      .background(.orangeDarkMode)
                      .clipShape(.rect(cornerRadius: 8))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 16)
            .padding(.top, UIScreen.main.bounds.height < 700 ? -40 : 8)
            .padding(.bottom, UIScreen.main.bounds.height < 700 ? 8 : 0)
            //.padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blankBackground)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(alignment: .top){
                    Button(action:{
                        router.pop()
                    }){
                        Image(systemName: "chevron.left")
                           .foregroundColor(.orangeDarkMode)
                           .font(.semibold16())
                           .bold()
                        
                         Text("Kembali".localized)
                           .foregroundColor(.orangeDarkMode)
                           .font(.semibold20())
                    }
                }
            }
        }
    }
}

#Preview{
    ChangeNameView()
        .environmentObject(Router())
}
