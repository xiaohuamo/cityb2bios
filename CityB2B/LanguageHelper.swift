//
//  LanguageHelper.swift
//  CityB2B
//
//  Created by Fei Wang on 9/3/2023.
//

import Foundation

struct LanguageHelper {
    
    func setLanguage(user: UserViewModel) -> String {
        var language: String
        
        // Check if user has selected a language
        if let deviceLanguage = Locale.preferredLanguages.first,
           let deviceLanguageCode = Locale.current.languageCode {
            // Check if device language is supported
            if deviceLanguageCode == "zh" {
                language = "zh-cn"
            } else {
                language = "en-us"
            }
        } else {
            // Default to English
            language = "en-us"
        }

        // Save the selected language to user defaults
        guard let userSelectedLanguage = user.currentLanguage else {
            user.currentLanguage = language
            UserDefaults.standard.set([language], forKey: "AppleLanguages")
            return language
        }

        language = userSelectedLanguage
        return language

    }
 
}





