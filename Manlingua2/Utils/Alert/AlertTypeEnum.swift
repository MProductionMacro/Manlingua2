//
//  AlertType.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 30/10/24.
//

import Foundation

enum AlertType {
    //MARK: Can add Custom alert if needed
    case confirmation
    case error

    var title: String {
        switch self {
        case .confirmation:
            return "Confirmation"
        case .error:
            return "Error"
        }
    }

    var message: String {
        switch self {
        case .confirmation:
            return "Are you sure you want to proceed?"
        case .error:
            return "Something went wrong. Please try again."
        }
    }

    var primaryButtonTitle: String {
        switch self {
        case .confirmation:
            return "OK"
        case .error:
            return "Retry"
        }
    }

    var dismissButtonTitle: String {
        switch self {
        case .confirmation:
            return "Cancel"
        case .error:
            return "Dismiss"
        }
    }
}
