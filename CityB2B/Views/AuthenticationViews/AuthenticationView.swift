//
//  AuthenticationView.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//

import SwiftUI


//默认为登陆页面
struct AuthenticationView: View {
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        VStack {
//            登陆页面
            SignInView()
        }
//        如果目前状态为报警，比如登陆出现问题，则弹出报警框，并可以关闭；
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
    
}

//登陆页面






