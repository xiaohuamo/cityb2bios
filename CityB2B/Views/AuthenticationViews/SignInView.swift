import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var user: UserViewModel
    @AppStorage("email") private var email:String = ""
    @AppStorage("password") private var password:String = ""
    @State private var isLoading: Bool = false
    @State var isSecured: Bool = true
    
    var body: some View {
        
        VStack {
            VStack{
              
                Text("登陆")
                    .padding([.top, .leading, .trailing])
                    .font(.system(size:20))
                    .bold()
                    .foregroundColor(Color("fontColorMain"))
                    .padding(.bottom,50)
                    .padding(.top,80)
              
                VStack{
                    TextField("输入email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("密码", text: $password)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()
                            } else {
                                TextField("密码", text: $password)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye").accentColor(.gray)
                        }.padding()
                        
                    }
                    
                    NavigationLink("忘记密码?", destination: ForgotPassword())
                        .padding([.leading, .bottom, .trailing])
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color.blue)
                    
                    Button {
                        if (!email.isEmpty && !password.isEmpty){
                            signin()
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
                        .navigationTitle("注册")
                        
                    
                }
                .padding()
                Spacer()
                
               
            }
            .navigationBarTitle("CityB2B")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    func signin() {
        
        user.signIn(email: email, password: password) { result in
            switch result {
            case .success:
              break
               
               
            case .failure(let error):
                user.alertTitle = "Errors"
                user.alertMessage = error.localizedDescription ?? "Something went wrong"
                user.showingAlert = true
            }
            self.isLoading = false
        }
    }
   
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
