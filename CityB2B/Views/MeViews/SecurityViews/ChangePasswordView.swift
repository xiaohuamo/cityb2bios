//
//  ChangePasswordView.swift
//  CityB2B
//
//  Created by Fei Wang on 25/2/2023.
//

import Foundation
import SwiftUI


struct ChangePasswordView: View{
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var showNotification = false
    @State var password :String = ""
    @State var newPassword :String = ""
    @State var newPassword2 :String = ""
    
    @State var isSecured: Bool = true
    @State var isSecured2: Bool = true
    @State var isSecured3: Bool = true
    

    @State private var isLoading: Bool = false
    @State private var showSuccessView: Bool = false
   
    
    
    @EnvironmentObject var user: UserViewModel
    
    var body: some View{
        VStack{
            HStack{
                ZStack(alignment: .trailing){
                    
                    Group{
                        if isSecured {
                            SecureField("当前密码", text: $password).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        } else {
                            TextField("当前密码", text: $password).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    Spacer()
                    Button {
                        isSecured.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    }.padding()
                    
                }
                
            }
            .padding([.top, .trailing, .leading])

            HStack{
                
                ZStack(alignment: .trailing){
                    
                    Group{
                        if isSecured2 {
                            SecureField("新密码", text: $newPassword).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        } else {
                            TextField("新密码", text: $newPassword).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    Spacer()
                    Button {
                        isSecured2.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    }.padding()
                    
                }
                
            }
            .padding([.top, .trailing, .leading])
            
            HStack{

                ZStack(alignment: .trailing){
                    
                    Group{
                        if isSecured3 {
                            SecureField("确认密码", text: $newPassword2).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        } else {
                            TextField("确认密码", text: $newPassword2).padding()
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    Spacer()
                    Button {
                        isSecured3.toggle()
                    } label: {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    }.padding()
                    
                }
                
            }
            .padding([.top, .trailing, .leading])
            
            Button {
                if !password.isEmpty && !newPassword.isEmpty && !newPassword2.isEmpty {
                    
                    password = String(password)
                    newPassword = String(newPassword)
                    newPassword2 = String(newPassword2)
                    if newPassword == newPassword2{
                        isLoading = true
                        changepassword1()
                          
                    } else {
                        user.alertTitle = "Error"
                        user.alertMessage = "New password fields must be the same"
                        user.showingAlert = true
                        
                    }
                } else {
                    
                    user.alertTitle = "Error"
                    user.alertMessage = "Field cannot be empty"
                    user.showingAlert = true
                }
                
            } label: {
                Text("确认")
                    .frame(width: 200, height: 50)
                    .bold()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(45)
                    .padding()
            }
            Spacer()
        }
        .navigationTitle("密码改变")
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
   
    }

    func changepassword1() {
        user.changePassword(User_temp_tokens: user.user_temp_tokens, oldpwd: password, password: newPassword, password2: newPassword2) { result in
            switch result {
            case .success:
                user.alertTitle = "成功"
                user.alertMessage = "密码修改成功"
                user.showingAlert = true
                presentationMode.wrappedValue.dismiss()
               
            case .failure:
                user.alertTitle = "失败"
                user.alertMessage = "密码修改失败"
                user.showingAlert = true
            }
            self.isLoading = false
        }
    }
}
struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
