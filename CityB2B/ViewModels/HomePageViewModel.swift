//
//  CartViewModel.swift
//  CityB2B
//
//  Created by Fei Wang on 3/2/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class HomePageViewModel: ObservableObject {
    
    @Published var homePageInfo: HomePageInfo?
    @Published var factorylistsOfCurrentUser =  [CurrentUserFactorys]()
    
    @Published var currentFactoryAndUserId: CurrentUserFactorys?
  
    //ALERTS
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
      
//    获得当前用户对应的首页信息
    func getHomePageInfo(User_temp_tokens : String ){
       
         
         let url = "https://m.marsfresh.com/api/index"
         let params = ["id": "0"] as [String : Any]
         let headers: HTTPHeaders = [
                         "token": User_temp_tokens
                       ]
         
         AF.request(url,
                    method: .post,
                    parameters: params,
                    encoding: URLEncoding.default, headers: headers).responseData {  response in
            
             switch response.result {
                 
                 
             case .success(let value):
                 let json = JSON(value)
                 let json1 = json["result"]
                 
                print("current factory list info is \(json1)")
                 self.homePageInfo =  self.setHomePageInfoData(Info : json1)
 
             case let .failure(error):
                 print("delete item faliuress")
             }
             
         }
      
        }
//设置相关的首页信息
    
    func isExistSupplierInArray(id : Int,supplier_list: [CurrentUserFactorys])->Bool{
        
        var find :Bool = false
        
        for name in supplier_list {
       
            if(name.id == id){
                find = true
            }
            
        }
        
       return find
    }
    
    func setHomePageInfoData(Info: JSON)->HomePageInfo {
      
        self.factorylistsOfCurrentUser.removeAll()
        
        var homePageInfodata : HomePageInfo?
        var suppliers_goods  = [Suppliers_goods]()
        var suppliers_goods_index :Int = 0
        
        var supplier_good : Suppliers_goods
        
        var category : CurrentuserCate?
        var currentUserFactory : CurrentUserFactorys
        
        var factoryList = [CurrentUserFactorys]()
        
        let is_has_suppliers = Info["is_has_suppliers"].intValue
        let is_has_supillers_match = Info["is_has_supillers_match"].intValue
        
    
        for (key1, value) in Info["suppliers_goods"] {
           
//        var factoryJsonValue =
            
            
            for (key1, value10) in value["factory"] {
                
                let id = value10["id"].intValue
                let user_id = value10["user_id"].intValue
                let logo = value10["logo"].stringValue
                let pic = value10["pic"].stringValue
                let business_nick_name = value10["business_nick_name"].stringValue
                let business_note = value10["business_note"].stringValue
                let googleMap = value10["googleMap"].stringValue
                let phone = value10["phone"].stringValue
                let displayName = value10["displayName"].stringValue
                
           
                
                currentUserFactory = CurrentUserFactorys(id:id,user_id: user_id,logo:logo,displayName: displayName,phone:phone,googleMap: googleMap,business_nick_name: business_nick_name,business_note: business_note,pic: pic)
                
                factoryList.append(currentUserFactory)
              
                if (self.isExistSupplierInArray(id:id,supplier_list: factorylistsOfCurrentUser) == false) {
                    self.factorylistsOfCurrentUser.append(currentUserFactory)
                }
               
            }
                
           
            
            
            var cateJsonValue = value["cate"]
            
            let idd = cateJsonValue["id"].stringValue
            let imageUrl = cateJsonValue["imageUrl"].stringValue
            let name_en = cateJsonValue["name_en"].stringValue
            let name = cateJsonValue["name"].stringValue
            let alias = cateJsonValue["alias"].stringValue
            
       
            
            category = CurrentuserCate(id:idd,name: name,name_en: name_en,alias: alias,imageUrl:imageUrl )
            
            
            supplier_good = Suppliers_goods(id:suppliers_goods_index,cate: category!, factory: factoryList)
            
            suppliers_goods.append(supplier_good)
            suppliers_goods_index += 1 
        }
        
        
        homePageInfodata = HomePageInfo(is_has_suppliers:is_has_suppliers,is_has_supillers_match:is_has_supillers_match,suppliers_goods:suppliers_goods)
        return homePageInfodata!
        
    }
        
    }

