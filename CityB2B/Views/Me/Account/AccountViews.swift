import SwiftUI

struct AccountViews: View {
    @Binding var showLoginView: Bool
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            List{
                NavigationLink(destination: CustomerinfoView()) {
                    Text("商家信息")
                }.padding(10)
                NavigationLink(destination: ContactInfoView()) {
                    Text("联系信息")
                }.padding(10)
                
                Button(action: {
                                    // 处理退出登录的逻辑
                    user.signOut()
                    self.showLoginView = true
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("退出登录")
                                            .foregroundColor(Color("fontColorMain"))
                                            .padding(10)
                                            .bold()
                                        
                                        Spacer()
                                    }
                                }
            }
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height: 300)
            .listRowInsets(EdgeInsets()) // 去除列表行的边距
            
            
            
        }
        .navigationBarTitle("我的账户", displayMode: .inline) // 设置导航栏标题的显示模式为 inline
        .navigationBarBackButtonHidden(true) // 隐藏返回按钮上的文字
        
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                Text("") // 空文本占位符
            }
        )
        
        Spacer()
    }
}

