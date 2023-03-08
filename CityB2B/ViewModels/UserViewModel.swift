//
//  UserViewModel.swift
//  ShoppingApp
//
//  Created by kz on 18/11/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import SwiftyJSON
import Alamofire




class UserViewModel: ObservableObject {
    
    
    
    @Published var user: User?
    @Published var currentUser: CurrentUser?
    @Published var addressList: [Address]?
    @Published var languageList: [Language]?
    @Published var currentAddress: Address1?
    
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    @Published var user_temp_tokens: String = ""
    
    @Published var emailColdSentSuccessful :Bool = false
    @Published var emailCodeverifiedSuccessful  :Bool = false
    @Published var loginSuccessful  :Bool = false
    
    //  获得用户授权信息
    
    
    //        获得用户授权信息
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    
    
    
    var uuid: String? {
        auth.currentUser?.uid
    }
    
    var userIsAuthenticated: Bool {
        auth.currentUser != nil || self.currentUser != nil
    }
    
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && userIsAuthenticated
    }
    
    var userIsAnonymous: Bool{
        auth.currentUser?.email == nil
    }
    
    
    
    
    func signUp(email: String, password: String, username: String){
        auth.createUser(withEmail: email, password: password){ (result, error) in
            if error != nil{
                self.alertTitle = "Error"
                self.alertMessage = error?.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            } else {
                DispatchQueue.main.async{
                    self.add(User(username: username, userEmail: email))
                    self.sync()
                }
            }
        }
    }
    
    
    func signUpEmail(email: String, password: String,passwordAgain: String,agree:Int, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/registerByEmail"
        let params = ["email":email,"password":password,"passwordAgain":passwordAgain,"agree":agree] as [String : Any]
        let headers: HTTPHeaders = []
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let token = json["result"]["token"].string {
                    self.user_temp_tokens = token
                    print("\(self.user_temp_tokens)")
                    self.sync()
                    self.loginSuccessful = true
                    completion(.success(token))
                } else {
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
                completion(.failure(error))
            }
        }
    }
    
   
        
        func saveConcatInfo(User_temp_tokens: String,firstName: String, lastName: String, tel: String, mobile : String, email: String, address: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/saveConcatInfo"
        let params = ["contactPersonFirstname":firstName,"contactPersonLastname":lastName,"tel":tel,"phone":mobile,"email":email,"address":address] as [String : Any]
        let headers: HTTPHeaders = [
            "token": User_temp_tokens
        ]
        
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                let status = json["status"].intValue
                if(status == 200 ){
                   self.sync()
                    completion(.success(("success")))
                   
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
                completion(.failure(error))
            }
        }
    }
    
    
    
  
    
    
    func saveAddressInfo(User_temp_tokens: String,id: Int, displayName: String, first_name: String, last_name : String, phone: String, email: String, address: String,isDefaultAddress: String, completion: @escaping (Result<String, Error>) -> Void) {
    let url = "https://m.marsfresh.com/api/addAddress"
    let params = ["id":id,"displayName":displayName,"first_name":first_name,"last_name":last_name,"phone":phone,"email":email,"address":address,"isDefaultAddress":isDefaultAddress] as [String : Any]
    let headers: HTTPHeaders = [
        "token": User_temp_tokens
    ]
    
    
    AF.request(url,
               method: .post,
               parameters: params,
               encoding: URLEncoding.default,
               headers: headers).responseData {  response in
        debugPrint(response)
        switch response.result {
        case .success(let value):
            
            let json = JSON(value)
            let status = json["status"].intValue
            if(status == 200 ){
               
                completion(.success(("success")))
               
            }else if(status == 100 ){
                let errorMessage = json["message"].stringValue
                let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                  
                completion(.failure(error))
                
            }else{
                let errorMessage = "发生错误"
                let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                completion(.failure(error))
            }
        case let .failure(error):
            self.alertTitle = "Errors"
            self.alertMessage = error.localizedDescription ?? "Something went wrong"
            self.showingAlert = true
            completion(.failure(error))
        }
    }
}
    
    func saveCustomerInfo(User_temp_tokens: String,untity_name: String, displayName: String,abn: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/saveCustomerInfo"
        let params = ["untity_name":untity_name,"displayName":displayName,"abn":abn] as [String : Any]
        let headers: HTTPHeaders = [
            "token": User_temp_tokens
        ]
        
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                
                
                
                let json = JSON(value)
                let status = json["status"].intValue
                if(status == 200 ){
                   self.sync()
                    completion(.success(("success")))
                   
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
                completion(.failure(error))
            }
        }
    }
    
    
    func signUpMobile(mobile: String, password: String,passwordAgain: String,agree:Int, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/registerByMobile"
        let params = ["mobile":mobile,"password":password,"passwordAgain":passwordAgain,"agree":agree] as [String : Any]
        let headers: HTTPHeaders = []
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let token = json["result"]["token"].string {
                    self.user_temp_tokens = token
                    print("\(self.user_temp_tokens)")
                    self.sync()
                    self.loginSuccessful = true
                    completion(.success(token))
                } else {
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
                completion(.failure(error))
            }
        }
    }
    
    
    func signUpEmail1(email: String, password: String,passwordAgain: String,agree:Int){
        
        
        let url = "https://m.marsfresh.com/api/registerByEmail"
        let params = ["email":email,"password":password,"passwordAgain":passwordAgain,"agree":agree] as [String : Any]
        let headers: HTTPHeaders = [
            
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let value1 = json["result"]
                DispatchQueue.main.async{
                    
                    self.user_temp_tokens = value1["token"].stringValue
                    
                    print("\(self.user_temp_tokens)")
                    //Success
                    self.sync()
                    self.loginSuccessful = true
                    
                }
                
                
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            }
            
        }
        
    }
    
  
    
    func resetPassword(name: String, password: String,passwordAgain: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/resetPassword"
        let params = ["name":name,"password":password,"passwordAgain":passwordAgain] as [String : Any]
        let headers: HTTPHeaders = [            ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                 let value1 = json["result"]
                      
                
                if(status == 200 ){
                    self.user_temp_tokens = value1["token"].stringValue
                    self.sync()
                    
                    completion(.success(()))
                }else if(status == 100 ){
                    let errorMessage = "用户已存在"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                    
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                    
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    
      
    
    func checkCode(name: String, code: String,type: String)  {
        
        //        self.emailCodeverifiedSuccessful = false
        
        let url = "https://m.marsfresh.com/api/checkCode"
        let params = ["name":name,"code":code,"type":type] as [String : Any]
        let headers: HTTPHeaders = [
            
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                
                if(status == 200 ){
                    
                    self.emailCodeverifiedSuccessful = true
                }else if(status == 100 ){
                    self.alertTitle = "Errors"
                    self.alertMessage =  "email 已存在"
                    self.showingAlert = true
                    
                }else{
                    self.alertTitle = "Errors"
                    self.alertMessage =  "发生错误"
                    self.showingAlert = true
                    
                }
                
                
                
                
                
                
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            }
            
        }
        
        
        
    }
    
//    检查当前输入的code是否匹配
    func checkCodeNew(name: String, code: String,type: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/checkCode"
        let params = ["name":name,"code":code,"type":type] as [String : Any]
        let headers: HTTPHeaders = [            ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                
                if(status == 200 ){
                    completion(.success(()))
                }else if(status == 100 ){
                    let errorMessage = "用户已存在"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                    
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                    
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }

    
    
    func signIn(email: String, password: String,completion: @escaping (Result<Void, Error>) -> Void){
        
        
        let url = "https://m.marsfresh.com/api/loginByPassword"
        let params = ["name":email,"password":password] as [String : Any]
        let headers: HTTPHeaders = [
            
        ]
        
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                 let value1 = json["result"]
                  
                
                if(status == 200 ){
                    
                    self.user_temp_tokens = value1["token"].stringValue
                    
                
                    self.sync()
                    completion(.success(()))
                }else if(status == 100 ){
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
        
        
        
        
    
    
    func checkMobileOrEmailIsExist(name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = "https://m.marsfresh.com/api/checkMobileOrEmailIsExist"
        let params = ["name":name] as [String : Any]
        let headers: HTTPHeaders = [
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                if(status == 200 ){
                    
                    completion(.success(()))
                }else if(status == 100 ){
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    
//    忘记密码检查输入名称是否存在
    func checkName(name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = "https://m.marsfresh.com/api/checkMobileOrEmailIsExist"
        let params = ["name":name] as [String : Any]
        let headers: HTTPHeaders = [
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                if(status == 200 ){
                    completion(.success(()))
                }else if(status == 100 ){
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    
    
    func sendEmailLogin(email: String, type: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = "https://m.marsfresh.com/api/sendEmail"
        let params = ["email":email,"type": type] as [String : Any]
        let headers: HTTPHeaders = [
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                if(status == 200 ){
                    self.emailColdSentSuccessful = true
                    completion(.success(()))
                }else if(status == 100 ){
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    
    
    func sendSms(lang: String, mobile: String,type: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = "https://m.marsfresh.com/api/sendSms"
        let params = ["lang":lang,"mobile":mobile,"type": type] as [String : Any]
        let headers: HTTPHeaders = [
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].intValue
                if(status == 200 ){
                    
                    completion(.success(()))
                }else if(status == 100 ){
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }else{
                    let errorMessage = "发生错误"
                    let error = NSError(domain: "MyDomain", code: status, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
            
        }
    }
    
    
    func singInAnonymously(){
        auth.signInAnonymously(){ authResult, error in
            DispatchQueue.main.async{
                //Success
                self.add(User(username: "guest", userEmail: "guest"))
                self.sync()
                
            }
            
        }
        
    }
    
   
    
    func signOut(){
        
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        self.currentUser = nil
        self.user_temp_tokens = ""
        self.user = nil
        
        
    }
    
    //MARK: firestore functions for user data
    
    func sync(){
        
        let url = "https://m.marsfresh.com/api/userInfo"
        let user_temp_tokens: String = self.user_temp_tokens
        
        let params = ["name":"aaa"]
        let headers: HTTPHeaders = [
            "token": user_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let value1 = json["result"]
                DispatchQueue.main.async{
                    
                    
                    print("\(value1)")
                    //Success
                    let name = value1["name"].stringValue
                    let id = value1["id"].intValue
                    
                    let password = value1["password"].stringValue
                    let avatar = value1["avatar"].stringValue
                    let pic = value1["pic"].stringValue
                    let role = value1["role"].intValue
                    let nickname = value1["nickname"].stringValue
                    let person_first_name = value1["person_first_name"].stringValue
                    let person_last_name = value1["person_last_name"].stringValue
                    let displayName = value1["displayName"].stringValue
                    let contactPersonFirstname = value1["contactPersonFirstname"].stringValue
                    let contactPersonLastname = value1["contactPersonLastname"].stringValue
                    let contactPersonNickName = value1["contactPersonNickName"].stringValue
                    let tel = value1["tel"].stringValue
                    let phone = value1["phone"].stringValue
                    let phone_verified = value1["phone_verified"].boolValue
                    let email = value1["email"].stringValue
                    let email_verified = value1["email_verified"].boolValue
                    let googleMap = value1["googleMap"].stringValue
                    let is_main_store = value1["is_main_store"].intValue
                    let user_name = value1["user_name"].stringValue
                    let is_set_password = value1["is_set_password"].intValue
                    let account_type = value1["account_type"].intValue
                    let merchant_service = value1["merchant_service"].arrayValue
                    let CountOfGroupMembers = value1["CountOfGroupMembers"].intValue
                    let abn_info_untity_name = value1["abn_info"]["untity_name"].stringValue
                    let abn_info_ABNorACN = value1["abn_info"]["ABNorACN"].stringValue
                    let abn_info = AbnInfo(untity_name: abn_info_untity_name, ABNorACN: abn_info_ABNorACN)
                    let notice = value1["notice"].arrayValue
                    
                    
                    self.user = User(username: name,  signUpDate : Date.now,userEmail: email)
                    
                    self.currentUser = CurrentUser(id: id, name: name, password: password, avatar: avatar, pic: pic, role: role, nickname: nickname, person_first_name: person_first_name, person_last_name: person_last_name, displayName: displayName, contactPersonFirstname: contactPersonFirstname, contactPersonLastname: contactPersonLastname, contactPersonNickName: contactPersonNickName, tel: tel, phone: phone, phone_verified: phone_verified, email: email, email_verified: email_verified, googleMap: googleMap, is_main_store: is_main_store, user_name: user_name, is_set_password: is_set_password, account_type: account_type, CountOfGroupMembers: CountOfGroupMembers, abn_info: abn_info)
                    
                }
                
                
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription ?? "Something went wrong"
                self.showingAlert = true
            }
            
        }
        
        
        /*
         guard userIsAuthenticated else { return }
         db.collection("Users").document(self.uuid!).getDocument { document, error in
         guard document != nil, error == nil else { return }
         do{
         try self.user = document!.data(as: User.self)
         } catch{
         print("sync error: \(error)")
         }
         
         } */
        
    }
    
    private func add(_ user: User){
        guard userIsAuthenticated else { return }
        do {
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)
            
        } catch {
            print("Error adding: \(error)")
        }
        
    }
    
    private func update(){
        guard userIsAuthenticatedAndSynced else { return }
        do{
            let _ = try db.collection("Users").document(self.uuid!).setData(from: user)
        } catch{
            print("error updating \(error)")
        }
        
    }
    
    func changePassword(User_temp_tokens: String, oldpwd: String,password : String,password2 : String ,completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/changePassword"
        
        let params = ["oldpwd":oldpwd,"password":password,"password2":password2] as [String : Any]
        let headers: HTTPHeaders = [
            "token": User_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let  status2  = json["status"].intValue
                if status2 == 200 {
                    completion(.success(()))
                } else {
                    let errorMessage = json["message"].stringValue
                    let error = NSError(domain: "MyDomain", code: status2, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    
    func getAddressList(User_temp_tokens: String){
        
        let user_temp_tokens: String = User_temp_tokens
        
        self.addressList = [Address]()
        
        
        let url = "https://m.marsfresh.com/api/addressList"
        
        let params = ["page":"1","limit":"20"] as [String : Any]
        let headers: HTTPHeaders = [
            "token": user_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            //      debug print 有值
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let json1 = json["result"]["data"]
                
                for (key, value) in json1 {
                    
                    let id = value["id"].intValue
                          let user_id = value["user_id"].intValue
                          let first_name = value["first_name"].stringValue
                          let last_name = value["last_name"].stringValue
                          let address = value["address"].stringValue
                          let phone = value["phone"].stringValue
                          let email = value["email"].stringValue
                          let id_number = value["id_number"].stringValue
                          let create_time = value["create_time"].intValue
                          let message_to_business = value["message_to_business"].string
                          let country = value["country"].stringValue
                          let addr_post = value["addr_post"].string
                          let is_default_address = value["isDefaultAddress"].intValue
                          let street_number = value["Street_number"].string
                          let display_name = value["displayName"].stringValue
                          let business_hours = value["business_hours"].stringValue
                          let arrive_mode = value["arrive_mode"].stringValue
                          let pic = value["pic"].stringValue

                          let singleaddress = Address(id: id, user_id: user_id, first_name: first_name, last_name: last_name, address: address, phone: phone, email: email, id_number: id_number, create_time: create_time, message_to_business: message_to_business, country: country, addr_post: addr_post, is_default_address: is_default_address, Street_number: street_number, display_name: display_name, business_hours: business_hours, arrive_mode: arrive_mode, pic: pic)
                          
                          self.addressList?.append(singleaddress)
                       
                }
            
                
            case let .failure(error):
                print("faliuress")
            }
            
        }
        
        
    }
    
    func getLanguageList(User_temp_tokens: String){
        
        let user_temp_tokens: String = User_temp_tokens
        
        self.languageList = [Language]()
        
        
        let url = "https://m.marsfresh.com/api/selectLanguage"
        
        let params = ["page":"1"] as [String : Any]
        let headers: HTTPHeaders = [
            "token": user_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            //      debug print 有值
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let json1 = json["result"]
                var id = 0
                for (key, value) in json1 {
                    
                            id += 1
                          let lang = value["lang"].stringValue
                          let lang_name = value["lang_name"].stringValue
                          let lang_name2 = value["lang_name2"].stringValue
                          let singlelanguage = Language(id: id, lang: lang, lang_name: lang_name, lang_name2: lang_name2)
                          
                          self.languageList?.append(singlelanguage)
                       
                }
            
                
            case let .failure(error):
                print("faliuress")
            }
            
        }
        
        
    }
    
    
    func getCurrentAddress(User_temp_tokens: String,id:Int, completion: @escaping (Result<Void, Error>) -> Void){
        
        let user_temp_tokens: String = User_temp_tokens
        
//        self.currentAddress = nil
        
        
        let url = "https://m.marsfresh.com/api/addressInfo"
        
        let params = ["id":id] as [String : Any]
        let headers: HTTPHeaders = [
            "token": user_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            //      debug print 有值
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let value = json["result"]
                let status = json["status"].intValue

                     let id = value["id"].intValue
                          let user_id = value["user_id"].intValue
                          let first_name = value["first_name"].stringValue
                          let last_name = value["last_name"].stringValue
                
                          let address = value["address"].stringValue
                          let phone = value["phone"].stringValue
                          let email = value["email"].stringValue
                          let id_number = value["id_number"].stringValue
                          let create_time = value["create_time"].intValue
                          let message_to_business = value["message_to_business"].string
                
                
                          let country = value["country"].stringValue
                          let addr_post = value["addr_post"].string
                          let is_default_address = value["isDefaultAddress"].intValue
                
                          let street_number = value["Street_number"].string
                          let display_name = value["displayName"].stringValue
                        

                          let singleaddress = Address1(id: id, user_id: user_id, first_name: first_name, last_name: last_name, address: address, phone: phone, email: email, id_number: id_number, create_time: create_time, message_to_business: message_to_business, country: country, addr_post: addr_post, is_default_address: is_default_address, Street_number: street_number, display_name: display_name)
                          
                          self.currentAddress = singleaddress
                       
                completion(.success(()))

            
                
            case let .failure(error):
               

                let errorMessage = "发生错误"
                               let error = NSError(domain: "MyDomain", code: 100, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                               completion(.failure(error))
            }
            
        }
        
        
    }
}
