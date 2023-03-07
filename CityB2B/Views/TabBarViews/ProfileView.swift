import SwiftUI
struct ProfileView: View {
    @EnvironmentObject var mysupplierVM:SupplierViewModel 
    @EnvironmentObject var user: UserViewModel
   
    @State private var showLoginView = false
    @Binding var isOrdersViewActive: Bool
   
    var body: some View {
        if (user.currentUser != nil && (user.currentUser?.id ?? 0 > 0)  )   {
            NavigationView{
                ZStack{
                    Rectangle() 
                        .foregroundColor(.white)
                        .padding(.top, 60)

                    VStack {
                        Circle()
                            .frame(width: 140)
                            .foregroundColor(.white)
                            .shadow(color: .orange, radius: 5)
                            .overlay(content: {
                                Image(systemName: "person")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            })
                            .padding(.top, 10)

                        VStack{
                            if !user.userIsAnonymous{
                                Text(user.user?.username ?? "Hello!").bold().font(.system(size: 20))
                            }
                            FunctionListView(showLoginView:$showLoginView)
//                            MeMenuListView( isOrdersViewActive:$isOrdersViewActive, showLoginView:$showLoginView)
//                            ScrollView{
//
//                                List{
//                                    Section(header: Text("通用")){
//                                        NavigationLink(destination: OrdersView(), label: {
//                                            Text("订单")
//                                        })
//                                    }
//
//                                }
//                                .listStyle(.grouped)
//                                .scrollDisabled(true)
//                                .scrollContentBackground(.hidden)
//                                .frame(height:100)
//
//                                List{
//                                    Section(header: Text("应用")){
//                                        NavigationLink(destination: NotificationsView(), label: {
//                                            Text("通知")
//                                        })
//                                        NavigationLink(destination: AboutAppView(), label: {
//                                            Text("应用信息")
//                                        })
//
//                                    }
//
//                                }
//                                .listStyle(.grouped)
//                                .scrollDisabled(true)
//                                .scrollContentBackground(.hidden)
//                                .frame(height:150)
//                                List{
//                                    Section(header: Text("账户")){
//                                        NavigationLink(destination: ChangePasswordView(), label: {
//                                            Text("改变密码")
//                                        })
//
//
//
//                                        Button(action: {
//                                            user.signOut()
//                                            self.showLoginView = true
//                                        }, label: {
//                                            Text("退出登录")
//                                                .foregroundColor(.red)
//                                        })
//
//                                    }
//                                }
//                                .listStyle(.grouped)
//                                .scrollDisabled(true)
//                                .scrollContentBackground(.hidden)
//                                .frame(height:175)
//                            }

                        }
                        .frame(maxWidth: .infinity, alignment: .top)

                        Spacer()
                    }
                }
                .navigationBarHidden(true) // 在这里隐藏导航栏
                

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.1))
            .onAppear{

            }
            .sheet(isPresented: $showLoginView, content: {
                SignInView()
            })
        } else {
            SignInView()
        }
    }
}


struct ProfileView_Previews: PreviewProvider {

    static var previews: some View {
        ProfileView(isOrdersViewActive: .constant((0 != 0)))
            .environmentObject(UserViewModel())
    }
}
