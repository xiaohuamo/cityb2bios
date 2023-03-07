//
//  ResetPasswordView.swift
//  ShoppingApp
//
//  Created by Fei Wang on 26/1/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State var email = ""
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack {
            VStack{
                VStack{
                    
                    TextField("Email", text: $email).padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                }
                
                Button {
                    if !email.isEmpty {
                        user.resetPassword(email: email)
                        
                    } else {
                        user.alertTitle = "Error"
                        user.alertMessage = "不能为空"
                        user.showingAlert = true
                    }
                    
                } label: {
                    Text("重置账户")
                        .frame(width: 200, height: 50)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(45)
                        .padding()
                }
                
            }
            .padding()
            Spacer()
        }
//        这里有一种方法将这个回复账户放到上面的导航条中
        .navigationTitle("恢复账户")
        
    }
    
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
