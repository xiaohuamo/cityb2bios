
import SwiftUI
import Foundation

struct RegistrationView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var functionsVM: FunctionsViewModel
    @State private var password: String = ""
    @State private var passwordAgain: String = ""
    @State private var isSecured: Bool = false
    @State private var agreeTerm: Bool = false
    @Binding var  email: String
    @State  var registerType : String = ""
    @State private var loginSuccess: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("创建账号")
                .font(.system(size:20))
                .bold()
                .padding(.bottom,50)
                .foregroundColor(Color("fontColorMain"))
                .frame(alignment: .center)
            
            PasswordTextField(label: "密码", isSecured: $isSecured, password: $password)
            
            PasswordTextField(label: "确认密码", isSecured: $isSecured, password: $passwordAgain)
            
            HStack {
                CheckboxField(isChecked: $agreeTerm)
                
                Button(action: {
                    // Show terms and conditions view
                }) {
                    Text("Agree to terms & conditions")
                        .foregroundColor(.blue)
                        .underline()
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Button(
                
                action: {
                    registerUser(registerType: registerType)
                    
                }, label: {
                    
                    Text("注册")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(agreeTerm ? Color.blue : Color.gray)
                        .cornerRadius(45)
                        .padding()
                    
                }).disabled(!agreeTerm)
            
            
        }
        .padding()
        .onAppear{
            let type1 = functionsVM.validateInput(email)
            registerType = String(type1)
            
        }
        
        NavigationLink(destination:  ProfileView(isOrdersViewActive: .constant((0 != 0))), isActive: $loginSuccess) {
            
            if( loginSuccess ==  true) {
                ProfileView(isOrdersViewActive: .constant((0 != 0)))
            }
            
        }
        
        
    }
    
    func registerUser(registerType:String) {
        guard !password.isEmpty && !passwordAgain.isEmpty && password == passwordAgain else {
            user.alertTitle = "Error"
            user.alertMessage = "请填写所有必填项并确保两次输入的密码一致"
            user.showingAlert = true
            return
        }
        
        if(registerType == "2") {
            
            user.signUpEmail(email: email, password: password, passwordAgain: passwordAgain, agree: agreeTerm ? 1 : 0) { result in
                switch result {
                case .success:
                    loginSuccess = true
                     user.loginSuccessful = false
                    presentationMode.wrappedValue.dismiss()
                       
                case .failure(let error):
                    user.alertTitle = "Errors"
                    user.alertMessage = error.localizedDescription ?? "Something went wrong"
                    user.showingAlert = true
                }
            }
            
        }else if(registerType == "1"){
            
            user.signUpMobile(mobile: email, password: password, passwordAgain: passwordAgain, agree: agreeTerm ? 1 : 0) { result in
                switch result {
                case .success:
                    loginSuccess = true
                     user.loginSuccessful = false
                    presentationMode.wrappedValue.dismiss()
                       
                case .failure(let error):
                    user.alertTitle = "Errors"
                    user.alertMessage = error.localizedDescription ?? "Something went wrong"
                    user.showingAlert = true
                }
            }
            
        }
    }
}

struct PasswordTextField: View {
    var label: String
    @Binding var isSecured: Bool
    @Binding var password: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if isSecured {
                SecureField(label, text: $password)
            } else {
                TextField(label, text: $password)
            }
            
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: isSecured ? "eye.slash" : "eye")
                    .foregroundColor(.secondary)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct CheckboxField: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked ? .blue : .secondary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        let email = Binding.constant("test@example.com")
        RegistrationView(email: email)
    }
}

