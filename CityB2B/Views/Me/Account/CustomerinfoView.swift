//
//  CustomerinfoView.swift
//  CityB2B
//
//  Created by Fei Wang on 3/3/2023.
//

import SwiftUI

struct CustomerinfoView: View {
    @EnvironmentObject var user: UserViewModel
    @State private var companyName = ""
    @State private var tradingName = ""
    @State private var abn = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView{
            VStack(spacing: 20) {

                // 公司名输入框
                InputView(label: "公司名", placeholder: "请输入公司名", text: self.$companyName)

                // Trading Name 输入框
                InputView(label: "Trading Name", placeholder: "请输入Trading Name", text: self.$tradingName)

                // ABN 输入框
                InputView(label: "ABN(9或11位数字)", placeholder: "请输入ABN", text: self.$abn, keyboardType: .numberPad)
                    .onChange(of: abn) { newValue in
                        // 去除中间和两边的空格
                        let trimmedValue = newValue.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespaces)
                        self.abn = trimmedValue.filter("0123456789".contains)
                        // 校验ABN格式
                        if !self.abn.isEmpty && (self.abn.count != 9 && self.abn.count != 11) {
                            self.abn = String(self.abn.prefix(11))
                            if self.abn.count == 11 {
                                self.abn.insert(" ", at: self.abn.index(self.abn.startIndex, offsetBy: 2))
                                self.abn.insert(" ", at: self.abn.index(self.abn.startIndex, offsetBy: 6))
                                self.abn.insert(" ", at: self.abn.index(self.abn.startIndex, offsetBy: 10))
                            }
                        }
                    }

                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("ABN格式错误"), message: Text("请输入9位或11位数字"), dismissButton: .default(Text("确定")))
                    }

                Spacer()
                // 保存按钮
                Button(action: {
                    if !self.abn.isEmpty && (self.abn.count != 9 && self.abn.count != 11) {
                        showAlert = true
                    } else {
                        
                        user.saveCustomerInfo(User_temp_tokens: user.user_temp_tokens,untity_name:companyName, displayName: tradingName,abn: abn) { result in
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
                }) {
                    Text("保存")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color("mainBlue"))
                        .cornerRadius(8)
                        .padding(.horizontal, 10)
                }
                .padding(.bottom, 100)
                .frame(maxWidth: .infinity)
            }
            .padding()
            .background(Color.white)
            .navigationBarTitle("客户信息")
            .navigationBarHidden(false)
            .onAppear{
                companyName = user.currentUser?.abn_info.untity_name ?? ""
                tradingName = user.currentUser?.displayName ?? ""
                abn = user.currentUser?.abn_info.ABNorACN ?? ""
            }
        }
        
    }

    @State private var showAlert = false
}



struct CustomerinfoView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerinfoView().environmentObject(UserViewModel())
    }
}


// 输入框
struct InputView: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    let keyboardType: UIKeyboardType

    init(label: String, placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType = .default) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
    }

    var body: some View {
        HStack {
            // 标签
            Text(label)
                .font(.headline)
                .foregroundColor(Color("fontColorMain"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 10)

            // 输入框
            TextField(placeholder, text: $text, onCommit: {
                validateInput()
            })
            .font(.headline)
            .foregroundColor(Color("fontColorMain"))
            .padding(8)
            .background(Color("backgroundColorMain"))
            .cornerRadius(8)
            .keyboardType(keyboardType)
        }
        Divider().padding(0)
    }
    
    func validateInput() {
        // 去除中间和两边的空格
        self.text = self.text.trimmingCharacters(in: .whitespaces)

        // 校验 ABN 格式，如果输入了 ABN，则必须是 9 位或 11 位数字，中间可以有空格
        if !self.text.isEmpty {
            let regex = try! NSRegularExpression(pattern: #"^(\d{2}\s?\d{3}\s?\d{3}\s?\d{3}|\d{11})$"#)
            let range = NSRange(location: 0, length: self.text.utf16.count)
            let isMatch = regex.firstMatch(in: self.text, options: [], range: range) != nil

            if !isMatch {
                // 如果不是合法的 ABN 格式，弹出警告框
                let alert = UIAlertController(title: "ABN 格式不正确", message: "ABN 必须是 9 位或 11 位数字，中间可以有空格", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))

                // 获取当前视图控制器
                let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
                if var topController = keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }

                    // 显示警告框
                    topController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}


