//
//  AlertModifier.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 30/10/24.
//

import Foundation
import SwiftUI

struct ReusableAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let alertData: AlertData
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(alertData.title),
                    message: Text(alertData.message),
                    primaryButton: .default(Text(alertData.primaryButtonTitle), action: alertData.primaryAction),
                    secondaryButton: .destructive(Text(alertData.dismissButtonTitle), action: alertData.dismissAction)
                )
            }
    }
}
