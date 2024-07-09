//
//  LanguageManager.swift
//  TestTiki
//
//  Created by Huy Trần on 6/7/24.
//
import Foundation
enum LanguageType: String, CaseIterable {
    case vi
    case en
}
final class LanguageManager {
    
    static var currentLanguage: LanguageType? {
        get {
            return UserDefaults.standard[#function]
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    static func setup() {
        if LanguageManager.currentLanguage == nil {
            LanguageManager.currentLanguage = LanguageType.vi
            let langStr = Locale.current.languageCode
            if langStr == "vi_VN" || langStr == "vi" {
                LanguageManager.currentLanguage = LanguageType.vi
            } else {
                LanguageManager.currentLanguage = LanguageType.en
            }
        }
    }
}

