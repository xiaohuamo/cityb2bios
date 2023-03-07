//
//  ItemViewModel.swift
//  CityB2B
//
//  Created by Fei Wang on 1/2/2023.
//

import Foundation

import SwiftUI
import SwiftyJSON
import Alamofire


class ItemViewModel: ObservableObject {
    
    
    
    
    @Published var items: [Item]?
    
    
    //ALERTS
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var productInfo: ProductInfo?
    
    
    func getProductInfo(factoryAndUser : CurrentUserFactorys,User_temp_tokens: String ,id:Int){
        
        let user_temp_tokens: String = User_temp_tokens
        
        self.productInfo = nil
        
        
        let url = "https://m.marsfresh.com/api/productInfo"
        let params = ["factory_id": factoryAndUser.id,"user_id": factoryAndUser.user_id,"user_branch_id":"0","id":id] as [String : Any]
        
        let headers: HTTPHeaders = [
            "token": user_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
//            debugPrint(response)
            //      debug print 有值
            switch response.result {
                
            case .success(let value1):
                let json = JSON(value1)
                let  value = json["result"]
//                print(" the product info is \(value)")
//                for (key, value) in json1 {
                let id = value["id"].intValue
                let parent_category_id = value["parent_category_id"].intValue
                
                let sub_category_id = value["sub_category_id"].intValue
                let parent_cat_name = value["parent_cat_name"].stringValue
                let sub_cat_name = value["sub_cat_name"].stringValue
                let menu_pic = value["menu_pic"].stringValue
                
                let menu_pic_300 = value["menu_pic_300"].stringValue
                let title = value["title"].stringValue
                let menu_id = value["menu_id"].stringValue
                let menu_desc = value["menu_desc"].stringValue
                let unit = value["unit"].stringValue
                let onSpecial = value["onSpecial"].intValue
                
                let hasGG = value["hasGG"].intValue
                let num = value["num"].intValue
                let old_price = value["old_price"].doubleValue
                let menu_price_fixed = value["menu_price_fixed"].intValue
                let grade_menu_price_fixed = value["grade_menu_price_fixed"].intValue
                let limit_buy_qty = value["limit_buy_qty"].intValue
                let qty = value["qty"].intValue
                  
             
                let menu_pics = self.setMenuPics(value: value["menu_pics"])
                
                let content = value["content"].stringValue
                let subtitle = value["subtitle"].stringValue
                let cover_pic = value["cover_pic"].stringValue
                let price = value["price"].doubleValue
                let bought = value["bought"].intValue
                
                
                let guige_des1 = self.setGuigeDesc(value: value["guige_des1"])
                
                let menu_option_list = self.setMenuOptionList(value: value["menu_option_list"])
                
       //         self.setDefault_address(value: value1["default_address"])
                
                let discount_show = value["discount_show"].stringValue
                
                self.productInfo = ProductInfo(id: id,parent_category_id: parent_category_id,sub_category_id: sub_category_id,parent_cat_name: parent_cat_name,sub_cat_name: sub_cat_name,menu_pic: menu_pic,menu_pic_300: menu_pic_300,title: title,menu_id: menu_id,menu_desc:menu_desc,unit: unit,onSpecial: onSpecial,hasGG: hasGG,num: num,old_price: old_price,menu_price_fixed: menu_price_fixed,grade_menu_price_fixed: grade_menu_price_fixed,limit_buy_qty: limit_buy_qty,qty: qty,menu_pics:menu_pics,content:content,subtitle: subtitle,cover_pic:cover_pic,price: price,bought: bought,guige_des1:guige_des1,menu_option_list: menu_option_list,discount_show: discount_show )
                  
            case let .failure(error):
                print("faliuress")
            }
            
        }
        
        
    }
    
//     设置规格
  
    
    func setGuigeDesc( value :JSON ) -> GuigeDesc1 {
        var guigeDesc1 : GuigeDesc1
        
        let id = value["id"].intValue
        let category_name = value["category_name"].stringValue
      
        guigeDesc1 = GuigeDesc1(id:id,category_name:category_name)
        
        return guigeDesc1
        
    }
    
    func setMenuPics( value :JSON ) -> [String] {
        var menu_pics = [String]()
        
        for (_, value1) in value {
            
            let menu_pic = value1.stringValue
             menu_pics.append(menu_pic)
         }
         return menu_pics
    }
    
    func setMenuOptionList( value :JSON ) -> [MenuOptionList] {
        var menuOptionList  = [MenuOptionList]()
        
        for (_, value) in value {
            
            let id = value["id"].intValue
            let menu_pic = value["menu_pic"].stringValue
            let price = value["price"].doubleValue
            let menu_desc = value["menu_desc"].stringValue
            let old_price = value["old_price"].doubleValue
            let menu_name = value["menu_name"].stringValue
            let islastBought = value["islastBought"].intValue
            let islastBought_desc = value["islastBought_desc"].stringValue
            let num = value["num"].intValue
                
          
         var  menuList = MenuOptionList(id:id,menu_pic:menu_pic,price:price,menu_desc:menu_desc,old_price:old_price,menu_name:menu_name,islastBought:islastBought,islastBought_desc:islastBought_desc)
            
            
            menuOptionList.append(menuList)
            
        }
        
       
        return menuOptionList
        
    }
    
    
    
    
    
    func getItems(factoryAndUser : CurrentUserFactorys,User_temp_tokens: String ){
        
        let user_temp_tokens: String = User_temp_tokens
        
        self.items = [Item]()
        
        
        let url = "https://m.marsfresh.com/api/productList"
        let params = ["factory_id": factoryAndUser.id,"type":"1","user_id": factoryAndUser.user_id,"limit":"400"] as [String : Any]
        
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
                //                print(" the json numbwer is \(json1)")
                for (key, value) in json1 {
                    
                    
                    let id = value["id"].intValue
                    let parent_category_id = value["parent_category_id"].stringValue
                    let sub_category_id = value["sub_category_id"].intValue
                    let parent_cat_name = value["parent_cat_name"].stringValue
                    
                    let sub_cat_name = value["sub_cat_name"].stringValue
                    let menu_pic = value["menu_pic"].stringValue
                    let menu_pic_300 = value["menu_pic_300"].stringValue
                    let title = value["title"].stringValue
                    let menu_id = value["menu_id"].stringValue
                    let menu_desc = value["menu_desc"].stringValue
                    
                    let unit = value["unit"].stringValue
                    
                    
                    let onSpecial = value["onSpecial"].intValue
                    let hasGG = value["hasGG"].intValue
                    let num = value["num"].intValue
                    let old_price = value["old_price"].doubleValue
                    let menu_price_fixed = value["menu_price_fixed"].intValue
                    
                    
                    let grade_menu_price_fixed = value["grade_menu_price_fixed"].stringValue
                    let limit_buy_qty = value["limit_buy_qty"].intValue
                    let qty = value["qty"].intValue
                    let subtitle = value["subtitle"].stringValue
                    let price = value["price"].doubleValue
                    let bought = value["bought"].intValue
                    let discount_show = value["discount_show"].stringValue
                    
                    
                    
                    
                    
                    var item = Item(id: id,parent_category_id: parent_category_id,sub_category_id: sub_category_id,parent_cat_name: parent_cat_name,sub_cat_name: sub_cat_name,menu_pic: menu_pic,menu_pic_300: menu_pic_300,title: title,menu_id: menu_id,menu_desc:menu_desc,unit: unit,onSpecial: onSpecial,hasGG: hasGG,num: num,old_price: old_price,menu_price_fixed: menu_price_fixed,grade_menu_price_fixed: grade_menu_price_fixed,limit_buy_qty: limit_buy_qty,qty: qty,subtitle: subtitle,price: price,bought: bought,discount_show: discount_show )
                    
                    self.items?.append(item)
                    //print(key)
                    //                    print(item)
                    
                }
                //                print(" the json numbwer is \(String(describing: self.items) )")
                
            case let .failure(error):
                print("faliuress")
            }
            
        }
        
        
    }
    
    
}

