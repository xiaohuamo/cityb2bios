import SwiftUI

struct languageViewExample: View {
    @EnvironmentObject var languageViewModel: LanguageViewModel
    @State private var refreshView = false

    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("app_name"))
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            Text(LocalizedStringKey("welcome_message"))
                .font(.headline)
                .multilineTextAlignment(.center)

            Button(action: {
                languageViewModel.language = "cn"
                refreshView.toggle()
            }) {
                Text("Switch to Chinese")
            }.id(languageViewModel.language) // 刷新视图

            Button(action: {
                languageViewModel.language = "en"
                refreshView.toggle()
            }) {
                Text("Switch to English")
            }
        }
        .padding()
        .onReceive([refreshView].publisher.first()) { _ in
            self.refreshView = true
        }
    }
}


struct languageViewExample_Previews: PreviewProvider {
    static var previews: some View {
        languageViewExample()
            .environmentObject(LanguageViewModel())
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
    }
}
