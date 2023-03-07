//
//  UserViewModel.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//


import SwiftUI
import SwiftyJSON
import Alamofire
import Foundation

class FunctionsViewModel: ObservableObject {
    
    
    //获得当前输入的类型
    func validateInput(_ input: String) -> Int {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let phoneRegex = "^04[0-9]{8}$"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        
        if emailPredicate.evaluate(with: input) {
            return 2 // email格式
        } else if phonePredicate.evaluate(with: input) {
            return 1 // 手机格式
        } else {
            return 0 // 格式错误
        }
    }
    
}
