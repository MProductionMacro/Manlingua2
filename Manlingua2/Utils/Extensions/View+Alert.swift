import SwiftUI

extension View {
    func reusableAlert(isPresented: Binding<Bool>, alertData: AlertData) -> some View {
        self.modifier(ReusableAlertModifier(isPresented: isPresented, alertData: alertData))
    }
}
