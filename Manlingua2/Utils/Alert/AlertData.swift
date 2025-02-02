import Foundation

struct AlertData {
    public let type: AlertType
    public let primaryAction: () -> Void
    public let dismissAction: (() -> Void)?
    
    public var title: String {
        //type.title
        "Apakah Anda yakin ingin untuk keluar?".localized
    }

    public var message: String {
        //type.message
        ""
    }

    public var primaryButtonTitle: String {
        //type.primaryButtonTitle
        "Batal".localized
    }

    public var dismissButtonTitle: String {
        //type.dismissButtonTitle
        "Keluar".localized
    }
}
