import SwiftUI
import Combine

struct LanguageSettingView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var functionsVM: FunctionsViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if (user.languageList != nil) {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(user.languageList!, id: \.id) { language1 in
                            LanguageItemView(language: language1, isSelected: language1.lang == user.currentLanguage, didSelectLanguage: { selectedLanguage in
                                user.currentLanguage = selectedLanguage.lang
                            })
                        }
                    }
                }
                .background(Color.white)
            }
            Spacer()
        }
        .onAppear {
            // 获取语言列表
            self.user.getLanguageList(User_temp_tokens: user.user_temp_tokens)
        }
        .navigationBarTitle("选择语言")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left").foregroundColor(Color("fontColorMain"))
                Text("")
            }
        })
        .onReceive(user.objectWillChange) { _ in
            // 当 currentLanguage 发生变化时，更新语言
       
            // 发送系统级通知，以便 UI 更新
            NotificationCenter.default.post(name: NSNotification.Name("changeLanguage"), object: nil)
        }
        
    }
}

struct LanguageItemView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    let language: Language
    let isSelected: Bool
    let didSelectLanguage: (Language) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 16) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isSelected ? Color("mainBlue") : .gray)
                VStack(alignment: .leading, spacing: 4) {
                    Text(language.lang_name)
                        .font(.headline)
                        .foregroundColor(.black)
                        .lineLimit(2)
                        .frame(alignment: .leading)
                    Text("\(language.lang_name2) ")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
                Spacer()
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                didSelectLanguage(language)
                print("current language is \(user.currentLanguage)")
                user.changeLanguage(lang: user.currentLanguage ?? "en-us"){ result in
                    switch result {
                    case .success:
                        // 不需要在这里更新语言，因为 onReceive 会自动处理
                        
                        let language = user.setLanguage(user: user)
                            UserDefaults.standard.set([language], forKey: "AppleLanguages")
                        presentationMode.wrappedValue.dismiss()
                           
                    case .failure(let error):
                        user.alertTitle = "Errors"
                        user.alertMessage = error.localizedDescription ?? "Something went wrong"
                        user.showingAlert = true
                    }
                }
            }
            Divider()
        }
    }
    
   
}


struct LanguageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        LanguageItemView(language: Language.sampleLanguage, isSelected: (1 != 0), didSelectLanguage: { selectedLanguage in
            // 在这里处理选择地址的逻辑
            print("选择的语言是：\(selectedLanguage)")
        }).environmentObject(UserViewModel())
    }
    
    
}

