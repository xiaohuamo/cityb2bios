//
//  SecurityMainView.swift
//  CityB2B
//
//  Created by Fei Wang on 2/3/2023.
//

import SwiftUI

struct SecurityMainView: View {
    var body: some View {
        VStack{
            List{
                HStack {
                   
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("修改密码").padding(10)
                    }
                    Spacer()
                }
                
                HStack{
                   
                    NavigationLink(destination: OrdersView()) {
                        Text("修改email").padding(10)
                    }
                    Spacer()
                    
                }
                HStack{
                   
                    NavigationLink(destination: OrdersView()) {
                        Text("修改手机号码").padding(10)
                    }
                    Spacer()
                    
                }
                
            }.background(Color("backgroundCat"))
                .listStyle(.grouped)
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .frame(height: 220)
                .listRowInsets(EdgeInsets())
                .padding(.bottom,20)// 去除列表行的边距
            Spacer()
        }
    }
}

struct SecurityMainView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityMainView()
    }
}
