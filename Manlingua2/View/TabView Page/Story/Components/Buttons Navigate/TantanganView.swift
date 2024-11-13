//
//  TantanganView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 17/10/24.
//

import SwiftUI

struct TantanganView: View {
    @EnvironmentObject var router: Router
  
    var body: some View {
       VStack(alignment: .leading, spacing: 0) {
          Text("Tantangan")
             .font(.judulBiasa())
             .padding(.leading, 24)
          
          HStack(spacing: 24) {
             Button {
                 router.push(.loadingPage(screen : .photoChallenge))
             } label: {
                EmptyView()
             }
             .buttonStyle(HomeNavigationButton(image: "camera", text: "Foto"))
             
             Button {
                router.push(.aiSimulation)
             } label: {
                EmptyView()
             }
             .buttonStyle(HomeNavigationButton(image: "bubble.left.and.text.bubble.right", text: "Simulasi"))
          }
          .padding(.vertical)
          .padding(.leading, 24)
       }
       .frame(maxWidth: .infinity, alignment: .leading)
       .padding(.bottom)
    }
}

#Preview {
    TantanganView()
       .environmentObject(Router())
}
