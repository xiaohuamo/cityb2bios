//
//  SignInView.swift
//  ShoppingApp
//
//  Created by Fei Wang on 26/1/2023.
//

import SwiftUI

struct SignInView: View {
    
//    以下命名是定义的是环境变量，也就是取环境变量，并且赋值为环境变量类型。 其实，不一定非要赋值。
    @EnvironmentObject var user: UserViewModel

    @State var email = ""
    @State var password = ""

    @State var isSecured: Bool = true
    
    var body: some View {
        VStack {
            VStack{
                VStack{
                    TextField("输入email", text: $email).padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("密码", text: $password).padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("密码", text: $password).padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye").accentColor(.gray)
                        }.padding()
                        
                    }
                    
                    NavigationLink("忘记密码?", destination: ResetPasswordView())
                        .padding([.leading, .bottom, .trailing])
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.blue)
                    
                    Button {
                        if (!email.isEmpty && !password.isEmpty){
                            user.signIn(email: email, password: password)
                        } else{
                            user.alertTitle = "错误"
                            user.alertMessage = "用户名与密码不能为空！"
                            user.showingAlert = true
                        }

                    } label: {
                        Text("登陆")
                            .frame(width: 200, height: 50)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(45)
                            .padding()

                    }

                    Text("没有账户?")
                        .padding([.top, .leading, .trailing])
                    NavigationLink("创建账户", destination: SignUpView()).padding([.leading, .bottom, .trailing]).foregroundColor(Color.blue)

                }
                .padding()
                Spacer()
                
                Button {

                    user.singInAnonymously()
                    
                } label: {
                    Text("访客登陆吧")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.blue)
                }

            }
            .navigationBarTitle("CityB2B")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("登陆")

        }
        
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
