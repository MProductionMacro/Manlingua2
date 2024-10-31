//
//  View+Alert.swift
//  Manlingua2
//
//  Created by Paulus Michael on 31/10/24.
//

import SwiftUI

extension View {
    func reusableAlert(isPresented: Binding<Bool>, alertData: AlertData) -> some View {
        self.modifier(ReusableAlertModifier(isPresented: isPresented, alertData: alertData))
    }
}
