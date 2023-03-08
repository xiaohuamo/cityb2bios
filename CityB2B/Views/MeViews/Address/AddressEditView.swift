//
//  AddressEditView.swift
//  CityB2B
//
//  Created by Fei Wang on 7/3/2023.
//

import SwiftUI

struct InputView1: View {
    @Environment(\.presentationMode) var presentationMode
    var label: String
    var placeholder: String
    @Binding var text: String
    var isValid: Bool?
    var keyboardType: UIKeyboardType
    var textwidth = UIScreen.main.bounds.width * 0.35 - 10
    var textFieldwidth = UIScreen.main.bounds.width * 0.65 - 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(label)
                    .frame(width: textwidth, alignment: .leading)
                    .font(.system(size: 18))
                    .foregroundColor(Color("fontColorMain"))
                    .padding(.leading,10)
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
                    .padding()
                    .lineLimit(2)
                    .cornerRadius(8)
                    .frame(width: textFieldwidth, alignment: .leading)
                    .foregroundColor(Color("fontColorMain"))
            }
            if let isValid = isValid, !isValid {
                Text("您输入的格式不正确")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding(.leading, textwidth + 20)
            }
        }
    }
}

struct InputView2: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var isValid: Bool?
    var keyboardType: UIKeyboardType
    var textwidth = UIScreen.main.bounds.width * 0.35 - 10
    var textFieldwidth = UIScreen.main.bounds.width * 0.65 - 10
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(label)
                    .frame(width: textwidth, alignment: .leading)
                    .font(.system(size: 18))
                    .foregroundColor(Color("fontColorMain"))
                    .padding(.leading,10)
                TextEditor(text: $text)
                    .frame(minHeight: 40, maxHeight: 60) // 设置最小高度和最大高度
                    .lineSpacing(5) // 行间距
                    .multilineTextAlignment(.leading) // 对齐方式
                    .disableAutocorrection(true) // 禁用自动更正
                    .foregroundColor(Color("fontColorMain"))
                    .overlay(
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                if text.isEmpty {
                                    Text("请输入地址")
                                        .foregroundColor(.gray)
                                        .padding(.top, 8)
                                        .padding(.leading, 4)
                                    
                                }
                                Spacer()
                            }
                            
                        }
                    )
                    .textContentType(.none) // 不设置文本内容类型
                    .keyboardType(keyboardType)
                    .padding()
                    .cornerRadius(8)
                    .frame(width: textFieldwidth, alignment: .leading)
            }
            if let isValid = isValid, !isValid {
                Text("您输入的格式不正确")
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .padding(.leading, textwidth + 20)
            }
        }
    }
}

struct AddressEditView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let address : Address
    @State private var customerName = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var tel = ""
    @State private var email = ""
    @State private var address11 = ""
    @State private var isDefaultAddress = false
    @State private var showAlert = false
    
    // 输入框内容校验
    private var isCustomerNameValid: Bool {
        return true
    }
    
    private var isFirstNameValid: Bool {
        return true
    }
    
    private var isLastNameValid: Bool {
       return true
    }
    
    private var isTelValid: Bool {
        if( tel.count >= 8 && tel.count <= 10 && tel.allSatisfy({ $0.isNumber }) || tel.isEmpty ) {
            return true
        }
        return false
    }
    
    private var isEmailValid: Bool {
        if( email.isValidEmail() || email.isEmpty ){
            return true
        }else{
            return false
        }
    }
    
    private var isAddressValid: Bool {
        return true 
    }
    
    
    
    var isSaveButtonEnabled: Bool {
        isCustomerNameValid && isAddressValid
        && (firstName.isEmpty || isFirstNameValid)
        && (lastName.isEmpty || isLastNameValid)
        && (tel.isEmpty || isTelValid)
        && (email.isEmpty || isEmailValid)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // 输入框
            VStack(alignment: .leading, spacing: 10) {
                InputView1(label: "客户名(*必填)", placeholder: "请输入客户名", text: $customerName, isValid: isCustomerNameValid, keyboardType: .default)
                    .padding(.leading, 10)
                
                InputView1(label: "First name", placeholder: "请输入First name", text: $firstName, isValid: isFirstNameValid, keyboardType: .default)
                    .padding(.leading, 10)
                
                InputView1(label: "Last name", placeholder: "请输入Last name", text: $lastName, isValid: isLastNameValid, keyboardType: .default)
                    .padding(.leading, 10)
                
                InputView1(label: "phone(*必填)", placeholder: "请输入电话", text: $tel, isValid: isTelValid, keyboardType: .numberPad)
                    .padding(.leading, 10)
                
                InputView1(label: "E-Mail", placeholder: "请输入email", text: $email, isValid: isEmailValid, keyboardType: .emailAddress)
                    .padding(.leading, 10)
                
                InputView2(label:"Address(*必填)",placeholder: "请输入地址", text: $address11,isValid: isAddressValid,keyboardType: .emailAddress)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 10)
                
                HStack {
                    Text("默认地址")
                        .padding(.leading, 20)
                        .foregroundColor(Color("fontColorMain"))
                        .font(.system(size: 18))
                   
                    Toggle(isOn: $isDefaultAddress) {
                        Text("")
                    }
                    Spacer(minLength: 10)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .padding(.trailing, 10)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .padding(.top, 10)
        .navigationBarTitle("编辑地址")
        .navigationBarBackButtonHidden()
        
        .navigationBarItems(leading: Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.left") .foregroundColor(Color("fontColorMain"))
                                Text("")
                            }
                        })
     
        .onAppear{
            self.user.getCurrentAddress(User_temp_tokens: user.user_temp_tokens,id:address.id)
            
            { result in
                switch result {
                case .success:
                    
                    customerName = user.currentAddress?.display_name ?? ""
                    firstName =  user.currentAddress?.first_name ?? ""
                    lastName = user.currentAddress?.last_name ?? ""
                    tel = user.currentAddress?.phone ?? ""
                    email = user.currentAddress?.email ?? ""
                    address11 = user.currentAddress?.address ?? ""
                    isDefaultAddress = ((user.currentAddress?.is_default_address) != 0)
                    
                case .failure(let error):
                    user.alertTitle = "Errors"
                    user.alertMessage = error.localizedDescription ?? "Something went wrong"
                    user.showingAlert = true
                }
            }
             
        }
        
        // 保存按钮
        Button(action: {
            //                      saveButtonAction()
            saveAddressInfo()
        }) {
            Text("保存")
                .foregroundColor(.white)
                .font(.system(size: 18))
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 50,alignment: .center)
        .background(isSaveButtonEnabled ? Color.blue : Color("grey1"))
        .cornerRadius(8)
        .padding(.top, 30)
        .padding(.leading,10)
        .disabled(!isSaveButtonEnabled)
        .padding(.bottom, 30)
    }
    
    // MARK: - Methods
    
    private func saveAddressInfo() {
        // TODO: Implement the logic to save
        var id : Int = 0
        if(address != nil) {
            id = address.id
        }
        var isDefault = "0"
        if (isDefaultAddress == true) {
            isDefault = "1"
        }
        user.saveAddressInfo(User_temp_tokens: user.user_temp_tokens, id: id, displayName: customerName, first_name: firstName, last_name: lastName, phone: tel, email: email, address: address11, isDefaultAddress: isDefault){ result in
            switch result {
            case .success:
                presentationMode.wrappedValue.dismiss()
                   
            case .failure(let error):
                user.alertTitle = "Errors"
                user.alertMessage = error.localizedDescription ?? "Something went wrong"
                user.showingAlert = true
            }
        }
    }
   
}


struct AddressEditView_Previews: PreviewProvider {
    static var previews: some View {
        AddressEditView(address: Address.sampleAddress).environmentObject(UserViewModel())
        
    }
}
