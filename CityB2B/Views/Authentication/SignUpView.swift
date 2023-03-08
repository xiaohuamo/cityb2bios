//
//  SignUpView.swift
//  ShoppingApp
//
//  Created by Fei Wang on 26/1/2023.
//


import SwiftUI


struct VerificationCodeButton: View {
    
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var functionsVM: FunctionsViewModel
    let email: String
   
    let onSuccess: () -> Void
    
    var body: some View {
        
        
            Button(action: {
            // Call API to send verification code to email address
            
                if (email.isEmpty){
                    user.alertTitle = "错误"
                    user.alertMessage = "请输入邮件或手机号码"
                    user.showingAlert = true
                }else{
                    let type = self.functionsVM.validateInput(email)
                     if(type == 0 ) {
                        user.alertTitle = "错误"
                        user.alertMessage = "输入格式不正确！"
                        user.showingAlert = true
                    
                    }else if(type == 2 ){
                        
                      
                        user.sendEmailLogin(email: email, type: 1) { result in
                            switch result {
                            case .success:
                               
                                    onSuccess()
                                   
                            case .failure(let error):
                                user.alertTitle = "Errors"
                                user.alertMessage = error.localizedDescription ?? "Something went wrong"
                                user.showingAlert = true
                            }
                        }

                           
                    }else if(type == 1 ){
                        
                        user.checkMobileOrEmailIsExist(name: email) { result in
                            switch result {
                            case .success:
                                user.alertTitle = "Errors"
                                user.alertMessage = "账户已存在！"
                                user.showingAlert = true
                               
                                   
                            case .failure(_):
                                
                                print("send mobile code !")
                                user.sendSms(lang: "zh-cn",mobile:email, type: "1") { result in
                                    switch result {
                                    case .success:
                                       
                                            onSuccess()
                                           
                                    case .failure(let error):
                                        user.alertTitle = "Errors"
                                        user.alertMessage = error.localizedDescription ?? "Something went wrong"
                                        user.showingAlert = true
                                    }
                                }
                                
//                            http://m.marsfresh.com/api/sendSms
                            }
                        }
                        
                        
                        
               
                    }else{
                        
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
    

}

struct VerificationCodeInput: View {
    @EnvironmentObject var functionsVM: FunctionsViewModel
    @EnvironmentObject var user: UserViewModel
    @Binding var verificationCode: String
    @Binding var email: String
    @State  var registerType : String = ""
    @State private var openview: Bool = false
    var body: some View {
        HStack {
            TextField("验证码", text: $verificationCode)
                .padding()
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Button(action: {
                // Verify code with API
                user.checkCode(name: email, code: verificationCode, type:registerType)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    // 这里写需要延迟2秒执行的代码
                    if user.emailCodeverifiedSuccessful {
                        openview = true
                        user.emailCodeverifiedSuccessful = false
                    
                    }
                }
               
            }) {
                Text("应用")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .transition(.opacity)
        }.sheet(isPresented: $openview) {
            // The view to be presented modally
            RegistrationView(email: $email)
        }.onAppear{
            let type1 = functionsVM.validateInput(email)
            registerType = String(type1)
            
        }
    }
}

struct SignUpView: View {
    
    @State var email = ""
    @State var username = ""
    @State var isEmailValid = false
    @State var verificationCode = ""
    @State var showVerificationCodeInput = false
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack{
            VStack{
               Spacer(minLength: 100)
                HStack {
                    TextField("输入手机号或电子邮件", text: $email/*, onEditingChanged: { isEditing in
                        if !isEditing {
                            isEmailValid = EmailValidator.validate(email: email)
                        }
                    }*/)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    
                    if !showVerificationCodeInput {
                        VerificationCodeButton(email: email, onSuccess: {
                            showVerificationCodeInput = true
                        })
//                        .disabled(!isEmailValid)
                        .transition(.opacity)
                    }
                }
                
                if showVerificationCodeInput {
                    VerificationCodeInput(verificationCode: $verificationCode,email: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                }
                
                Spacer(minLength: 50)
            }
            .padding()
            Spacer()
        }
        .navigationTitle("注册")
    }
}



