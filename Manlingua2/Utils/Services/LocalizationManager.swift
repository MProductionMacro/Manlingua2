//
//  LocalizationManager.swift
//  Manlingua2
//
//  Created by Arrick Russell Adinoto on 19/11/24.
//
import Foundation

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    
    @Published var selectedLanguage: Language {
        didSet {
            UserDefaults.standard.set(selectedLanguage.rawValue, forKey: languageKey)
        }
    }
    
    private let languageKey = "language"
    
    enum Language: String {
        case english = "en"
        case indonesian = "id"
    }
    
    init() {
        let savedLanguage = UserDefaults.standard.string(forKey: languageKey) ?? Language.english.rawValue
        self.selectedLanguage = Language(rawValue: savedLanguage) ?? .english
    }
    
    func localizedString(for key: String) -> String {
        let languageCode = selectedLanguage.rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return key
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: "")
    }
}
