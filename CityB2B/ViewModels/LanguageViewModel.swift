import Foundation

class LanguageViewModel: ObservableObject {
    @Published var language = Locale.preferredLanguages.first ?? "en" {
        didSet {
            loadStrings()
        }
    }
    private let fallbackLanguage = "en"
    
    init() {
        loadStrings()
    }
    
    private func loadStrings() {
        if let path = Bundle.main.path(forResource: "Localizable_\(language)", ofType: "strings") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                dict.forEach { key, value in
                    Bundle.main.localizedString(forKey: key, value: value, table: nil)
                }
            }
        } else if language != fallbackLanguage {
            language = fallbackLanguage
        }
    }
}
