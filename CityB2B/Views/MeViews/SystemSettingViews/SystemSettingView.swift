import SwiftUI
import Foundation

struct SystemSettingView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var cacheSize: String = "0"
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: LanguageSettingView()) {
                    Text("语言设置")
                }.padding(10)
                
                NavigationLink(destination: EmptyView()) {
                                   HStack {
                                       Text("清除缓存")
                                       Spacer()
                                       Text(cacheSize)
                                   }
                                   .onTapGesture {
                                       clearCache()
                                   }
                               }.padding(10)
                
                NavigationLink(destination: AboutAppView()) {
                    Text("关于我们")
                }.padding(10)
                
                NavigationLink(destination: PrivacyPolicyView()) {
                    Text("隐私协议")
                }.padding(10)
                
                NavigationLink(destination: TermAndConditionsView()) {
                    Text("用户协议")
                }.padding(10)
                
                NavigationLink(destination: ContactInfoView()) {
                    Text("检测新版本")
                }.padding(10)
                
            }
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height: 800)
            .listRowInsets(EdgeInsets())
            .foregroundColor(Color("fontColorMain"))
        }
        .navigationBarTitle("设置", displayMode: .inline)
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
