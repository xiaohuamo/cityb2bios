//
//  Language.swift
//  CityB2B
//
//  Created by Fei Wang on 8/3/2023.
//

import Foundation

struct Language: Codable,Identifiable {
    var id: Int
    var lang: String
    var lang_name: String
    var lang_name2: String
   
}

extension Language {
    static var sampleLanguage: Language {
        return Language(id:1,
                        lang: "zh-cn",
                        lang_name:"简体中文",
                        lang_name2: "简体中文"
                     )
    }
    
    static var sampleLanguages: [Language] {
        return [
            Language(id:1,lang: "zh-cn",
                     lang_name:"简体中文",
                     lang_name2: "简体中文"),
            Language(id:2,lang: "en-us",
                     lang_name: "English",
                     lang_name2: "英文")
        ]
    }
}
