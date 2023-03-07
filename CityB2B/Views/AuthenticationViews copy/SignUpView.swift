//
//  SignUpView.swift
//  ShoppingApp
//
//  Created by Fei Wang on 26/1/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var username = ""
    
    @EnvironmentObject var user: UserViewModel

    @State var isSecured: Bool = true
    @State var isSecuredConfirmation: Bool = true


    var body: some View {
        VStack {
            VStack{
                VStack{
                    TextField("用户名", text: $username)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    TextField("email", text: $email)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("密码", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("密码", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }
                        .padding()
                        
                    }
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecuredConfirmation {
                                SecureField("确认密码", text: $passwordConfirmation)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("确认密码", text: $passwordConfirmation)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecuredConfirmation.toggle()
                        } label: {
                            Image(systemName: self.isSecuredConfirmation ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }.padding()
                        
                    }
                    
                    Button {
                        if (!username.isEmpty && !email.isEmpty && !password.isEmpty && !passwordConfirmation.isEmpty ){
                            if password == passwordConfirmation {
                                user.signUp(email: email, password: password, username: username)
                            }
                            else{
                                user.alertTitle = "Error"
                                user.alertMessage = "用户名或email不能为空"
                                user.showingAlert = true
                            }
                            
                        } else {
                            user.alertTitle = "Error"
                            user.alertMessage = "用户名密码不能为空"
                            user.showingAlert = true
                        }
                        
                    } label: {
                        Text("创建")
                            .frame(width: 200, height: 50)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(45)
                            .padding()

                    }

                }
                .padding()
                Spacer()
            }
            .navigationTitle("创建账户")

        }
        
    }
    
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
