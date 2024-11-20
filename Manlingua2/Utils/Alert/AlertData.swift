//
//  AlertData.swift
//  SampleMacro
//
//  Created by Reynard Octavius Tan on 30/10/24.
//

import Foundation

struct AlertData {
    let type: AlertType
    let primaryAction: () -> Void
    let dismissAction: (() -> Void)?
    
    var title: String {
        //type.title
        "Apakah Anda yakin ingin untuk keluar?".localized
    }

    var message: String {
        //type.message
        ""
    }

    var primaryButtonTitle: String {
        //type.primaryButtonTitle
        "Batal".localized
    }

    var dismissButtonTitle: String {
        //type.dismissButtonTitle
        "Keluar".localized
    }
}
