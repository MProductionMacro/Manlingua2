//
//  DetailIoTSettingView.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 12/11/24.
//

import SwiftUI

struct DetailIoTSettingView : View {
    @EnvironmentObject var router: Router
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 16){
                Text("Pengaturan IoT".localized)
                    .font(.heavy32())
                
                DetailIoTRowView(label: "Nama Perangkat".localized, value: "Smart Speaker Rumah", isEditable: true)

                
                DetailIoTRowView(label: "Nama Model".localized, value: "Smart Speaker Bluetooth 1")
                
                DetailIoTRowView(label: "Nomor Seri".localized, value: "202411080001")
                
                DetailIoTRowView(label: "Nama Wifi".localized, value: "Muo Home")

                Spacer()
                
                Button {

                } label: {
                    Text("Hapus Perangkat".localized)
                        .foregroundStyle(.fontColors)
                      .frame(maxWidth: .infinity)
                }
                .buttonStyle(SecondaryButton(isDisabled: false))
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
                            .font(.semibold20())
                            .bold()
                    
                        Text("Kembali".localized)
                            .foregroundColor(.orangeDarkMode)
                            .font(.semibold16())
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview{
    NavigationView{
        DetailIoTSettingView()
            .environmentObject(Router())
            .environment(\.colorScheme, .dark)
    }
}
