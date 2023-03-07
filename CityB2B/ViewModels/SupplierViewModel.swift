//
//  SupplierViewModel.swift
//  CityB2B
//
//  Created by Fei Wang on 1/3/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire


class SupplierViewModel: ObservableObject {
    
    
    
    @Published var mySuppliers: [MySupplier]?
    
    
    @Published var newSupplierCount: Int = 0
    
    @Published var myNewSuppliers: [MyNewSupplier]?
    
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    func getMysupplierList(User_temp_tokens: String ,type:String){
        
        let user_temp_tokens: String = User_temp_tokens
        
        self.mySuppliers = [MySupplier]()
        
        
        let url = "https://m.marsfresh.com/api/supplierListOfCurrentUser"
        let params = ["type":"1"] as [String : Any]
        
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
                
                for (key, value) in json1 {
                    
                    
                    let id = value["id"].intValue
                    let user_id = value["user_id"].intValue
                    let logo = URL(string: value["logo"].stringValue)
                    let displayName = value["displayName"].stringValue
                    let phone = value["phone"].stringValue
                    let googleMap = value["googleMap"].stringValue
                    let business_nick_name = value["business_nick_name"].stringValue
                    let business_note = value["business_note"].stringValue
                    let pic = URL(string: value["pic"].stringValue)
                    let categoryId = value["categoryId"].dictionaryObject as? [String: String] ?? [:]
                    let remark_name = value["remark_name"].stringValue
                    let py = value["py"].stringValue
                    
                    let mySupplier = MySupplier(id: id, user_id: user_id, logo: logo, displayName: displayName, phone: phone, googleMap: googleMap, business_nick_name: business_nick_name, business_note: business_note, pic: pic, categoryId: categoryId, remark_name: remark_name, py: py)
                    
                    self.mySuppliers?.append(mySupplier)
                    
                }
            
                
            case let .failure(error):
                print("faliuress")
            }
            
        }
        
        
    }
    
    
    func getMyNewsupplierList(User_temp_tokens: String){
        
        let user_temp_tokens: String = User_temp_tokens
        
        self.myNewSuppliers = [MyNewSupplier]()
        
        
        let url = "https://m.marsfresh.com/api/newSupplierListOfCurrentUser"
        
        let params = ["type":"1"] as [String : Any]
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
                
                for (key, value) in json1 {
                    
                    
                    let id = value["id"].intValue
                    let user_id = value["user_id"].intValue
                    let logo = URL(string: value["logo"].stringValue)
                    let displayName = value["displayName"].stringValue
                    let phone = value["phone"].stringValue
                    let pic = URL(string: value["pic"].stringValue)
                    let type = value["type"].intValue
                    let status = value["status"].intValue
              
                    let myNewSupplier = MyNewSupplier(id: id, user_id: user_id, logo: logo, displayName: displayName, phone: phone,  pic: pic, type: type, status: status)
                    
                    self.myNewSuppliers?.append(myNewSupplier)
                    
                }
            
                
            case let .failure(error):
                print("faliuress")
            }
            
        }
        
        
    }
    
    
    
    func clientIsAgreeJoinSupplier(User_temp_tokens: String, factory_id: String, user_id: String, status1: String, completion: @escaping (Int) -> Void) {
            
            var status: Int = 0
            let user_temp_tokens: String = User_temp_tokens
            
            let url = "https://m.marsfresh.com/api/clientIsAgreeJoinSupplier"
            
            let params = ["factory_id": factory_id, "user_id": user_id, "status": status1] as [String : Any]
            let headers: HTTPHeaders = [
                "token": user_temp_tokens
            ]
            
            AF.request(url,
                       method: .post,
                       parameters: params,
                       encoding: URLEncoding.default, headers: headers).responseData { response in
                debugPrint(response)
                
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status2 = json["status"].intValue
                    if status2 == 200 {
                        if status1 == "1" {
                            status = 1
                        }
                        if status1 == "0" {
                            status = 2
                        }
                    }
                    completion(status)
                case let .failure(error):
                    print("failures: \(error)")
                    completion(status)
                }
            }
        }

    
    func newSupplierCount(User_temp_tokens: String ){
        
       
        let user_temp_tokens: String = User_temp_tokens
        
      
        
        
        let url = "https://m.marsfresh.com/api/newSupplierCount"
        
        let params = ["factory_id":0] as [String : Any]
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
                let  status2  = json["status"].intValue
                if(status2 == 200) {
                    
                    self.newSupplierCount = json["result"].intValue
                  
                    
                }
                
              
            
                
            case let .failure(error):
                print("faliuress")
            }
            
        }
        
        
    }
    
    func inviteCodeJoinSupplier(User_temp_tokens: String, code: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "https://m.marsfresh.com/api/inviteCodeJoinSupplier"
        
        let params = ["code":code] as [String : Any]
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


}

