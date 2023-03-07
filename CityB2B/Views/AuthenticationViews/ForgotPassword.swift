//
//  ForgotPassword.swift
//  ShoppingApp
//
//  Created by Fei Wang on 26/1/2023.
//


import SwiftUI


struct VerificationCodeButton1: View {
    
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var functionsVM: FunctionsViewModel
    let username: String
    
    let onSuccess: () -> Void
    
    var body: some View {
        
        
        Button(action: {
            // Call API to send verification code to username address
            
            if (username.isEmpty){
                user.alertTitle = "错误"
                user.alertMessage = "请输入邮件或手机号码"
                user.showingAlert = true
            }else{
                let type = self.functionsVM.validateInput(username)
                if(type == 0 ) {
                    user.alertTitle = "错误"
                    user.alertMessage = "输入格式不正确！"
                    user.showingAlert = true
                    
                }else{
                    //                        检查当前用户是否存在
                   
                    checkIfUserIsExist(username:username,type:type)
                    
                }
            }
        }) {
            Text("验证码")
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    
    func sendVerificationCode(username:String,type:Int) {
        
        if(type == 2 ) {
            user.sendEmailLogin(email: username, type: 3) { result in
                switch result {
                case .success:
                    
                    onSuccess()
                    
                case .failure(let error):
                    user.alertTitle = "Errors"
                    user.alertMessage = error.localizedDescription ?? "Something went wrong"
                    user.showingAlert = true
                }
            }
        }
        
        
        if(type == 1) {
            user.sendSms(lang: "zh-cn",mobile:username, type: "3") { result in
                switch result {
                case .success:
                    
                    onSuccess()
                    
                case .failure(let error):
                    user.alertTitle = "Errors"
                    user.alertMessage = error.localizedDescription ?? "Something went wrong"
                    user.showingAlert = true
                }
            }
        }
        
        
    }
    
    func  checkIfUserIsExist(username:String,type:Int) ->Bool{
        var isExist : Bool = false
        
        user.checkName(name: username)
        { result in
            switch result {
            case .success:
                isExist = true
                sendVerificationCode(username:username,type:type)
            case .failure(let error):
                user.alertTitle = "Errors"
                user.alertMessage = error.localizedDescription
                user.showingAlert = true
            }
        }
        
        return isExist
    }
    
}

struct VerificationCodeInput1: View {
    @EnvironmentObject var functionsVM: FunctionsViewModel
    @EnvironmentObject var user: UserViewModel
    @Binding var verificationCode: String
    @Binding var username: String
    @State  var registerType : String = ""
    @State private var openview: Bool = false
    var body: some View {
        HStack {
            TextField("验证码", text: $verificationCode)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Button(action: {
                
                user.checkCodeNew(name: username, code: verificationCode, type:"3") { result in
                    switch result {
                    case .success:
                        openview = true
                        
                    case .failure(let error):
                        user.alertTitle = "Errors"
                        user.alertMessage = error.localizedDescription ?? "Something went wrong"
                        user.showingAlert = true
                    }
                }
            }
                   
            ) {
                Text("应用")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .transition(.opacity)
        }.sheet(isPresented: $openview) {
            // The view to be presented modally
            ResetPasswordView(username: $username)
        }.onAppear{
            let type1 = functionsVM.validateInput(username)
            registerType = String(type1)
            
        }
    }
}

struct ForgotPassword: View {
    
    //    @State var username = ""
    @State var username = ""
    @State var isEmailValid = false
    @State var verificationCode = ""
    @State var showVerificationCodeInput1 = false
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack{
            VStack{
                Spacer(minLength: 100)
                HStack {
                    TextField("输入手机号或电子邮件", text: $username)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    if !showVerificationCodeInput1 {
                        VerificationCodeButton1(username: username, onSuccess: {
                            showVerificationCodeInput1 = true
                        })
                        
                        .transition(.opacity)
                    }
                }
                
                if showVerificationCodeInput1 {
                    VerificationCodeInput1(verificationCode: $verificationCode,username: $username)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                }
                
                Spacer(minLength: 50)
            }
            .padding()
            Spacer()
        }
        .navigationTitle("忘记密码")
    }
}



