import Foundation
import SwiftUI

struct ReusableAlertModifier: ViewModifier {
    @Binding public var isPresented: Bool
    public let alertData: AlertData
    
    public func body(content: Content) -> some View {
        content
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(alertData.title),
                    message: Text(alertData.message),
                    primaryButton: .cancel(Text(alertData.primaryButtonTitle).bold(), action: alertData.primaryAction),
                    secondaryButton: .default(Text(alertData.dismissButtonTitle).foregroundStyle(.blue), action: alertData.dismissAction)

                )
            }
    }
}
