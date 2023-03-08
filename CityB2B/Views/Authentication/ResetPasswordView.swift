
import SwiftUI
import Foundation

struct ResetPasswordView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var functionsVM: FunctionsViewModel
    @State private var password: String = ""
    @State private var passwordAgain: String = ""
    @State private var isSecured: Bool = false
 
    @Binding var  username: String
    @State  var registerType : String = ""
    @State private var loginSuccess: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("重置密码")
                .font(.system(size:20))
                .bold()
                .padding(.bottom,50)
                .foregroundColor(Color("fontColorMain"))
                .frame(alignment: .center)
            
            PasswordTextField1(label: "密码", isSecured: $isSecured, password: $password)
            
            PasswordTextField(label: "确认密码", isSecured: $isSecured, password: $passwordAgain)
            
            HStack {
             
                
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
                        .background(Color.blue)
                        .cornerRadius(45)
                        .padding()
                    
                })
            
            
        }
        .padding()
        .onAppear{
            let type1 = functionsVM.validateInput(username)
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
        
   
//            此处替换为复位密码api
            user.resetPassword(name:username, password: password, passwordAgain: passwordAgain) { result in
                switch result {
                case .success:
                    loginSuccess = true
                    presentationMode.wrappedValue.dismiss()
                       
                case .failure(let error):
                    user.alertTitle = "Errors"
                    user.alertMessage = error.localizedDescription ?? "Something went wrong"
                    user.showingAlert = true
                }
            }
            
       
    }
}

struct PasswordTextField1: View {
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




struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        let email = Binding.constant("test@example.com")
        RegistrationView(email: email)
    }
}

