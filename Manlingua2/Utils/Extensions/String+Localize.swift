import Foundation

extension String {
    public var localized: String {
        LocalizationManager.shared.localizedString(for: self)
    }
}
