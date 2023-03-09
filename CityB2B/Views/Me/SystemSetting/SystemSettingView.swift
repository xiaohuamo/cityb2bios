import SwiftUI
import Foundation

struct SystemSettingView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var functionsVM: FunctionsViewModel
    
    @Environment(\.presentationMode) var presentationMode
    @State private var cacheSize: String = "0"
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: LanguageSettingView()) {
                    Text(LocalizedStringKey("language_setting"))
                }.padding(10)
                
                NavigationLink(destination: EmptyView()) {
                                   HStack {
                                       Text(LocalizedStringKey("clear_cache"))
                                       Spacer()
                                       Text(cacheSize)
                                   }
                                   .onTapGesture {
                                       clearCache()
                                   }
                               }.padding(10)
                
                NavigationLink(destination: AboutAppView()) {
                    Text(LocalizedStringKey("about_us"))
                }.padding(10)
                
                NavigationLink(destination: PrivacyPolicyView()) {
                    Text(LocalizedStringKey("privacy_policy"))
                }.padding(10)
                
                NavigationLink(destination: TermAndConditionsView()) {
                    Text(LocalizedStringKey("user_agreement"))
                }.padding(10)
                
                NavigationLink(destination: ContactInfoView()) {
                    Text(LocalizedStringKey("detect_new_version"))
                }.padding(10)
                
            }
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height: 800)
            .listRowInsets(EdgeInsets())
            .foregroundColor(Color("fontColorMain"))
        }
        .navigationBarTitle(LocalizedStringKey("settings"), displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                Text("")
            }
        )
        .onAppear {
            cacheSize = getCurrentCacheSizeInMB()
        }
        .onReceive(user.objectWillChange) { _ in
                   // 当 currentLanguage 发生变化时，更新语言
          
            
            let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
            let currentLanguage = languages?.first
            print("当前语言类型：", currentLanguage)
                   // 发送系统级通知，以便 UI 更新
                   NotificationCenter.default.post(name: NSNotification.Name("changeLanguage"), object: nil)
               }
    }
    
    func getCurrentCacheSizeInMB() -> String {
        let cacheSize = Double(URLCache.shared.currentDiskUsage) / (1024.0 * 1024.0)
        let formattedSize = String(format: "%.2f", cacheSize)
        return formattedSize + " MB"
    }
    
    func clearCache() {
            URLCache.shared.removeAllCachedResponses()
            cacheSize = getCurrentCacheSizeInMB()
        }
}


struct SystemSettingView_Previews: PreviewProvider {
    static var previews: some View {
        SystemSettingView()
    }
}
