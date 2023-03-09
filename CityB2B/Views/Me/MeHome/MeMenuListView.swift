//
//  MeMenuListView.swift
//  CityB2B
//
//  Created by Fei Wang on 25/2/2023.
//

import SwiftUI

struct MeMenuListView: View {
    @EnvironmentObject var user: UserViewModel
    @Binding var isOrdersViewActive: Bool
    @Binding var showLoginView: Bool
    var body: some View {
        ScrollView{
            Button("Show Orders") {
                            isOrdersViewActive = true
                OrdersView()
                        }
            List{
                Section(header: Text("通用")){
                    NavigationLink(destination: OrdersView(), label: {
                        Text("订单")
                    })
                  
                    
                    NavigationLink(
                                    destination: OrdersView(),
                                    isActive: $isOrdersViewActive
                                ) {
                                    Text("订单2")
                                }
                    
                   
                }

            }
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height:100)

            List{
                Section(header: Text("应用")){
                    NavigationLink(destination: NotificationsView(), label: {
                        Text("通知")
                    })
                    NavigationLink(destination: AboutAppView(), label: {
                        Text("应用信息")
                    })

                }

            }
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height:150)
            List{
                Section(header: Text("账户")){
                    NavigationLink(destination: ChangePasswordView(), label: {
                        Text("改变密码")
                    })

                   

                    Button(action: {
                        user.signOut()
                        self.showLoginView = true
                    }, label: {
                        Text("退出登录")
                            .foregroundColor(.red)
                    })

                }
            }
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height:175)
        }
    }
}


