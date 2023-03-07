//
//  AddressEditView.swift
//  CityB2B
//
//  Created by Fei Wang on 7/3/2023.
//

import SwiftUI

struct InputView1: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var isValid: Bool?
    var keyboardType: UIKeyboardType
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: UIScreen.main.bounds.width * 0.35, alignment: .leading)
                .font(.headline)
                .padding(.leading,10)
            TextField(placeholder, text: $text)
                .keyboardType(keyboardType)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .frame(width: UIScreen.main.bounds.width * 0.65, alignment: .leading)
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
        !customerName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private var isFirstNameValid: Bool {
        !firstName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private var isLastNameValid: Bool {
        !lastName.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private var isTelValid: Bool {
        tel.count >= 8 && tel.count <= 10 && tel.allSatisfy({ $0.isNumber })
    }
    
    private var isEmailValid: Bool {
        email.isValidEmail()
    }
    
    private var isAddressValid: Bool {
        !address11.trimmingCharacters(in: .whitespaces).isEmpty
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
                InputView1(label: "客户名(* must)", placeholder: "请输入客户名", text: $customerName, isValid: isCustomerNameValid, keyboardType: .default)
                    .padding(.leading, 10)
                
                InputView1(label: "First name", placeholder: "请输入First name", text: $firstName, isValid: isFirstNameValid, keyboardType: .default)
                    .padding(.leading, 10)
                
                InputView1(label: "Last name", placeholder: "请输入Last name", text: $lastName, isValid: isLastNameValid, keyboardType: .default)
                    .padding(.leading, 10)
                
                InputView1(label: "Tel(8-10位数字)", placeholder: "请输入电话", text: $tel, isValid: isTelValid, keyboardType: .numberPad)
                    .padding(.leading, 10)
                
                InputView1(label: "E-Mail", placeholder: "请输入email", text: $email, isValid: isEmailValid, keyboardType: .emailAddress)
                    .padding(.leading, 10)
                
                InputView1(label:"Address(* must)",placeholder: "请输入地址", text: $address11,isValid: isAddressValid,keyboardType: .emailAddress)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                
                    .padding(.leading, 10)
                
                HStack {
                    Text("默认地址")
                        .padding(.leading, 20)
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    Spacer()
                    Toggle(isOn: $isDefaultAddress) {
                        Text("")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .padding(.trailing, 10)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
        .padding(.top, 10)
        .navigationBarTitle("编辑地址")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{
            self.user.getCurrentAddress(User_temp_tokens: user.user_temp_tokens,id:address.id)
            
            customerName = user.currentAddress?.display_name ?? ""
            firstName =  user.currentAddress?.first_name ?? ""
            lastName = user.currentAddress?.last_name ?? ""
            tel = user.currentAddress?.phone ?? ""
            email = user.currentAddress?.email ?? ""
            address11 = user.currentAddress?.address ?? ""
            isDefaultAddress = ((user.currentAddress?.is_default_address) != 0)
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
    }
    
    // MARK: - Methods
    
    private func saveAddressInfo() {
        // TODO: Implement the logic to save
    }
    
    
}


struct AddressEditView_Previews: PreviewProvider {
    static var previews: some View {
        AddressEditView(address: Address.sampleAddress).environmentObject(UserViewModel())
        
    }
}
