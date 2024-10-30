//
//  DeviceInfoView.swift
//  Manlingua2
//
//  Created by Reynard Octavius Tan on 30/10/24.
//

import SwiftUI
struct DeviceInfoView: View {
    @State private var deviceInfo: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(DeviceSize.shared.displayDeviceInfo())
                .font(.system(.body, design: .monospaced))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.05))
                )
        }
        .padding()
    }
}

#Preview {
    DeviceInfoView()
}
