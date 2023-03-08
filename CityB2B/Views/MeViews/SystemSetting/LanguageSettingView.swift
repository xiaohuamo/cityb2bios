import SwiftUI

struct LanguageSettingView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isActive = false
    var body: some View {
        VStack{
        
            
            if (user.languageList != nil) {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(user.languageList!, id: \.id) { language1 in
                            LanguageItemView(language: language1, isSelected: false , didSelectLanguage: { selectedLanguage in
                                user.languageList
                            })
                        }
                    }
                }
                .background(Color.white)
            }
            Spacer() // 添加一个 Spacer 视图，以使按钮位于底部
                      // 在 VStack 的外面添加一个 Button 视图
            Button(action: {
                
                self.isActive = true
                // 点击按钮时的操作
                // 这里我们可以使用 NavigationLink 进行页面跳转
               
               
            }) {
                HStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("mainBlue"))
                    Text("添加地址")
                        .foregroundColor(Color("mainBlue"))
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("mainBlue"), lineWidth: 1)
            )
            

            .padding(.bottom, 16)
                  }.onAppear{
//            获得地址列表
            self.user.getLanguageList(User_temp_tokens: user.user_temp_tokens)
        }
       
        .navigationBarTitle("选择语言")
         .navigationBarTitleDisplayMode(.inline)
//        @Environment(\.presentationMode) var presentationMode
         .navigationBarBackButtonHidden()
         .navigationBarItems(leading: Button(action: {
                             self.presentationMode.wrappedValue.dismiss()
                         }) {
                             HStack {
                                 Image(systemName: "chevron.left") .foregroundColor(Color("fontColorMain"))
                                 Text("")
                             }
                         })
        
    }
    
   
}

struct LanguageItemView: View {
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
                    .padding(.trailing,20)
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
            }
            Divider()
        }
    }
    
}

struct LanguageSettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        LanguageItemView(language: Language.sampleLanguage, isSelected: (1 != 0), didSelectLanguage: { selectedLanguage in
            // 在这里处理选择地址的逻辑
            print("选择的地址是：\(selectedLanguage)")
        }).environmentObject(UserViewModel())
    }
    
    
}

