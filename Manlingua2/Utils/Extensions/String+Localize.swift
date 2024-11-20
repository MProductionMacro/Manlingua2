//
//  String+Localize.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 19/11/24.
//

import Foundation

extension String {
    var localized: String {
        LocalizationManager.shared.localizedString(for: self)
    }
}
