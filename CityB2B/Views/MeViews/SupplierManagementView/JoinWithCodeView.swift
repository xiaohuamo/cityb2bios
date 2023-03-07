//
//  JoinWithCodeView.swift
//  CityB2B
//
//  Created by Fei Wang on 1/3/2023.
//



import SwiftUI

struct JoinWithCodeView: View {
    @EnvironmentObject var mysupplierVM:SupplierViewModel
    @EnvironmentObject var user: UserViewModel
    @State private var code: String = ""
    @State private var showSuccessAlert: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var isLoading: Bool = false
    @State private var showSuccessView: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: NewSupplierView(), isActive: $showSuccessView) {
                EmptyView()
            }
            TextField("请输入邀请码", text: $code)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                isLoading = true
                joinWithCode()
            }) {
                Text("完成")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("mainBlue"))
                    .cornerRadius(10)
            }
            .padding()
            .disabled(isLoading)
            .overlay(
                Group {
                    if isLoading {
                        ProgressView()
                    }
                }
            )
            
            Spacer()
        }
        .alert(isPresented: $showSuccessAlert) {
            Alert(
                title: Text("加入成功"),
                message: Text("您已成功加入供应商"),
                dismissButton: .default(Text("确认")) {
                    // 返回商家视图
                }
            )
        }
        .alert(isPresented: $showErrorAlert) {
            Alert(
                title: Text("错误"),
                message: Text("邀请码错误，请重试"),
                dismissButton: .default(Text("确认"))
            )
        }
       
      
    }
    
    func joinWithCode() {
        mysupplierVM.inviteCodeJoinSupplier(User_temp_tokens: user.user_temp_tokens, code: code) { result in
            switch result {
            case .success:
                self.showSuccessView = true
            case .failure:
                self.showErrorAlert = true
            }
            self.isLoading = false
        }
    }


}


struct JoinWithCodeView_Previews: PreviewProvider {
    static var previews: some View {
        JoinWithCodeView()
    }
}
