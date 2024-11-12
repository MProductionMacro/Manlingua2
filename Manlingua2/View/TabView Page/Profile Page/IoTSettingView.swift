//
//  IoTSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 12/11/24.
//

import SwiftUI

struct IoTSettingView: View {
    @EnvironmentObject var router: Router
    var body: some View {
        VStack{
            /*
            VStack(alignment: .leading, spacing: 32){
                VStack(alignment: .leading, spacing: 16){
                    Text("Pengaturan IoT")
                        .font(.heavy32())
                    
                    Text("Hubungkan perangkat IoT ke aplikasi untuk mulai menggunakan flashcard!")
                        .font(.subJudul())
                        .opacity(0.65)
                    
                    VStack(alignment: .leading, spacing: 16){
                        Text("Daftar perangkat:")
                            .font(Font.normal16())
                        
                        
                        
                        HStack(alignment: .center){
                            
                        }
                        .frame(width: 361, height: 78)
                        .background(.cardBackground)
                        .cornerRadius(8)
                        .shadow(color: .cardShadow.opacity(0.15), radius: 5, x: 0, y: 0)

                        
                    }
                }
                .padding(.top, 27)

                
                Spacer()
                
  
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            */
            
            VStack(alignment: .leading, spacing: 16){
                Text("Pengaturan IoT")
                    .font(.heavy32())
                    .padding(.bottom, -8)
                
                Text("Hubungkan perangkat IoT ke aplikasi untuk mulai menggunakan flashcard!")
                    .font(.subJudul())
                    .opacity(0.65)
                
                VStack(alignment: .leading, spacing: 16){
                    Text("Daftar perangkat:")
                        .font(Font.normal16())
                    
                    ForEach(1...3, id: \.self) { i in
                        IoTCardView()
                            .onTapGesture{
                                router.push(.detailIoTSetting)
                            }
                    }
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
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
                            .font(.semibold20())
                            .bold()
                    
                        Text("Kembali")
                            .foregroundColor(.orangeDarkMode)
                            .font(.semibold16())
                            .bold()
                    }
                }
            }
            
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack(alignment: .top){
                    Button(action:{
                    }){
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                            .frame(width: 35, height: 35)
                            .background(.orangeDarkMode)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView{
        IoTSettingView()
            .environmentObject(Router())
    }
}
