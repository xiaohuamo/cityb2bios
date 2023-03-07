//
//  ContactInfoView.swift
//  CityB2B
//
//  Created by Fei Wang on 3/3/2023.
//

import SwiftUI

struct ContactInfoView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var tel = ""
    @State private var mobile = ""
    @State private var email = ""
    @State private var address = ""
    @State private var showAlert = false
    
    // 输入框内容校验
    private var isFirstNameValid: Bool {
        !firstName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private var isLastNameValid: Bool {
        !lastName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private var isTelValid: Bool {
        tel.count >= 8 && tel.count <= 10 && tel.allSatisfy({ $0.isNumber })
    }
    
    private var isMobileValid: Bool {
        mobile.count == 10 && mobile.allSatisfy({ $0.isNumber })
    }
    
    private var isEmailValid: Bool {
        email.isValidEmail()
    }
    
    private var isAddressValid: Bool {
        !address.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
          
            
            // 输入框
            VStack(alignment: .leading, spacing: 10) {
                InputView(label: "First name (* must)", placeholder: "Tony", text: $firstName)
                    .padding(.leading, 10)
                   
                
                InputView(label: "Last name (* must)", placeholder: "Musk", text: $lastName)
                    .padding(.leading, 10)
                    
                
                InputView(label: "Tel(8-10位数字)", placeholder: "请输入电话", text: $tel)
                    .padding(.leading, 10)
                    
                    .keyboardType(.numberPad)
                
                InputView(label: "Mobile", placeholder: "请输入手机号", text: $mobile)
                    .padding(.leading, 10)
                    
                    .keyboardType(.numberPad)
                
                InputView(label: "E-Mail", placeholder: "请输入email", text: $email)
                    .padding(.leading, 10)
                    
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                
                InputView(label: "Address (* must)", placeholder: "请输入地址", text: $address)
                    .padding(.leading, 10)
                   
                
                Button(action: {
                    // 确认按钮点击事件
                    if isFirstNameValid && isLastNameValid {
                        
                        user.saveConcatInfo(User_temp_tokens: user.user_temp_tokens,firstName:firstName, lastName: lastName,tel: tel,mobile:mobile,email:email,address:address) { result in
                            switch result {
                            case .success:
                                presentationMode.wrappedValue.dismiss()
                                   
                            case .failure(let error):
                                user.alertTitle = "Errors"
                                user.alertMessage = error.localizedDescription ?? "Something went wrong"
                                user.showingAlert = true
                            }
                        }
                        
//                        user.addContactInfo(firstName: firstName, lastName: lastName, tel: tel, mobile : String, email: String, address: String)
                        
                        // 返回到上一页
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        user.alertTitle = "提示"
                        user.alertMessage = "请补全信息"
                        user.showingAlert = true
                        
                    }
                }) {
                    Text("确认")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                        .background(Color("mainBlue"))
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
               
                
                Spacer()
            }
            .padding(.horizontal, 20)
         }
        .padding()
        .background(Color.white)
        .navigationBarTitle("客户信息")
        .navigationBarHidden(false)
        .onAppear{
            
            firstName = user.currentUser?.person_first_name ?? ""
            lastName = user.currentUser?.person_last_name ?? ""
            tel = user.currentUser?.tel ?? ""
            mobile = user.currentUser?.phone ?? ""
            email = user.currentUser?.email ?? ""
            address = user.currentUser?.googleMap ?? ""
          
        }
    }
}

struct ContactInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContactInfoView()
    }
}

// 字符串扩展，用于判断邮箱格式是否正确
extension String {
    func isValidEmail() -> Bool {
        // 正则表达式判断邮箱格式
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}

