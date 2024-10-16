//
//  CloudKitTestView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 13/10/24.
//

import SwiftUI

struct CloudKitTestView: View {
   @StateObject private var vm = CloudKitService()
   
   var body: some View {
      Text("IS SIGNED IN: \(vm.isSignedIntoCloud.description.uppercased())")
      Text(vm.error)
   }
}

#Preview {
   CloudKitTestView()
}
