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

class CartViewModel: ObservableObject {
    
   
    
   
    @Published var carts: [Cart]?
    @Published var currentcart: Cart?
    @Published var cartTotalMoney: Double = 0.00
    
  

    //ALERTS
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
     
    
    func removeProductFromCart(itemId: Int,factoryAndUser : CurrentUserFactorys,User_temp_tokens: String ){
        
        let user_temp_tokens: String = User_temp_tokens
        
        var itemIds = [Int]()
        
        itemIds.append(itemId)
       
        
        print("hi , remove the product \(itemIds)")
        
       let url = "https://m.marsfresh.com/api/deleteCartItem"
        let params = ["id_arr"
                      : itemIds,"factory_id":factoryAndUser.id,"user_id":factoryAndUser.user_id,"user_branch_id ":  "0"] as [String : Any]
        let headers: HTTPHeaders = [
                        "token": user_temp_tokens
                      ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            print("delete xxxx item success \(response)")
            switch response.result {
                
                
            case .success(let value):
                print("delete item success")
                
                
                let arr : [CartItem] = (self.currentcart?.items)!
               
                var i :Int = 0
              
                for arrayItem in arr {
                   
                    if( arrayItem.idd == itemId) {
//                        print("PARA: \(arrayItem.idd)")
                        self.currentcart?.items?.remove(at: i)
                        
                    }
                    i = i+1
                }
                
                self.getCartTotalMoney(factoryAndUser : factoryAndUser,User_temp_tokens: User_temp_tokens ,user_branch_id :   "0")
                
//                print("delete xxxxxxx item success \( self.currentcart?.items)")
            case let .failure(error):
                print("delete item faliuress")
            }
            
        }
       
    }
    
    
    func updateCartItemQuantity(itemId: Int,factoryAndUser : CurrentUserFactorys,User_temp_tokens: String ,Number:Int){
             
            let user_temp_tokens: String = User_temp_tokens
        
        
        
        
        let url = "https://m.marsfresh.com/api/updateCartItemQuantity"
        let params = ["factory_id":factoryAndUser.id,"user_id":factoryAndUser.user_id,"id" : itemId,"number" : Number ,"user_branch_id ":  "0"] as [String : Any]
        let headers: HTTPHeaders = [
                        "token": user_temp_tokens
                      ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
               
            case .success(let value):
                
                self.getCartTotalMoney(factoryAndUser : factoryAndUser,User_temp_tokens: User_temp_tokens ,user_branch_id :   "0")
                print("success")
//                self.getCartItems(factoryAndUser : factoryAndUser,User_temp_tokens: User_temp_tokens ,user_branch_id :   "0")
            case let .failure(error):
                print("faliuress")
            }
            
        }
    }
    
    
    
    
    
    
    func addItemToCart(itemId: Int,factoryAndUser : CurrentUserFactorys,User_temp_tokens: String ,Number:Int,guige_ids:Int){
             
            let user_temp_tokens: String = User_temp_tokens
        
        
        
        
        let url = "https://m.marsfresh.com/api/addCart"
        let params = ["factory_id":factoryAndUser.id,"user_id":factoryAndUser.user_id,"id" : itemId,"guige_ids": guige_ids,"number" : Number ,"user_branch_id ":  "0"] as [String : Any]
        let headers: HTTPHeaders = [
                        "token": user_temp_tokens
                      ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
               
            case .success(let value):
                
                
                print("success")
                self.getCartItems(factoryAndUser : factoryAndUser,User_temp_tokens: User_temp_tokens ,user_branch_id :   "0")
            case let .failure(error):
                print("faliuress")
            }
            
        }
    }
    
    
//    将某一条购买记录插入到model的 item 结构中
    func insertItemsToCartModel(CartItems:JSON)->[CartItem]{
        var cartItem : CartItem
        var itemss = [CartItem]()
        
        for (key, value) in CartItems {
            
            
//            let businessUserId = value["businessUserId"].stringValue
//            let userId = value["userId"].stringValue
            
            let idd  = value["idd"].intValue
            let userId = value["userId"].intValue
            let businessUserId = value["businessUserId"].intValue
            let title = value["title"].stringValue
            let num = value["num"].intValue
            let price = value["price"].stringValue
            let old_price = value["old_price"].stringValue
            let guige_des = value["guige_des"].stringValue
            let guige_ids = value["guige_ids"].stringValue
            let id = value["id"].stringValue
            let coupon_name_en = value["coupon_name_en"].stringValue
            let onSpecial = value["onSpecial"].intValue
            let rm_id = value["rm_id"].intValue
            let menu_pic_100 = value["menu_pic_100"].stringValue
            let menu_pic = value["menu_pic"].stringValue
            
            let bonusType = value["bonusType"].intValue
            let unit = value["unit"].stringValue
            let item_message = value["item_message"].stringValue
            let menu_id = value["menu_id"].stringValue
            let visible = value["visible"].intValue
            let limit_buy_qty = value["limit_buy_qty"].intValue
           
            let qty = value["qty"].intValue
            let subtitle = value["subtitle"].stringValue
            let menu_name = value["menu_name"].stringValue
            let hasGG = value["hasGG"].intValue
            
            
         
            
            
             cartItem = CartItem(idd:idd,userId:userId,businessUserId:businessUserId,title:title,num:num,price:price,old_price:old_price,guige_des:guige_des,guige_ids:guige_ids,id:id,coupon_name_en:coupon_name_en,onSpecial:onSpecial,rm_id:rm_id,menu_pic_100:menu_pic_100,menu_pic:menu_pic,bonusType:bonusType,unit:unit,item_message:item_message,menu_id:menu_id,visible:visible,limit_buy_qty:limit_buy_qty,qty:qty,subtitle:subtitle,menu_name:menu_name,hasGG:hasGG)
            
            
            itemss.append(cartItem)
        }
//        print(" items valuesss is \(itemss)")
       return itemss
        
    }
    
    
    
    func getCartItems(factoryAndUser : CurrentUserFactorys,User_temp_tokens: String ,user_branch_id : String){
        
        let user_temp_tokens: String = User_temp_tokens
        self.currentcart = nil
        
        
        
        let url = "https://m.marsfresh.com/api/factoryCartList"
        let params = ["factory_id":factoryAndUser.id,"user_id":factoryAndUser.user_id,"user_branch_id ": user_branch_id] as [String : Any]
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
                let value = json["result"]
               
                
//                每一个Cart 是一个供应商的临时数据
//                var carts :[Cart]
//                每一个CartItem是一条购买记录 ， cartitems是 一个用户基于一个供应商的购买记录
                var cartItems :[CartItem]
                
//                for (key, value) in json1 {
                    
                     
                    
                    let businessUserId = value["businessUserId"].stringValue
                    let userId = value["userId"].stringValue
                    let businessUserName = value["businessUserName"].stringValue
                    let logo = value["logo"].stringValue
                    let pic = value["pic"].stringValue
                   
                    let items_count = value["items_count"].intValue
                    let items_money = value["items_money"].stringValue
                    let estimate_delivery_fee = value["estimate_delivery_fee"].stringValue
                    
                     cartItems = self.insertItemsToCartModel(CartItems:value["items"])
             
//                    print(" trrrhe carts items \(value["items"])")
  
//                   print(" return cartimtes \(cartItems)")
                    
                   
                self.cartTotalMoney = value["items_money"].doubleValue
                self.currentcart  = Cart(businessUserId: businessUserId,userId: userId,businessUserName: businessUserName,logo: logo,pic: pic,items: cartItems,items_count: items_count,items_money: items_money,estimate_delivery_fee: estimate_delivery_fee)
  
               
                
//               print(" the cartitems is \(String(describing:  self.currentcart) )")
               
            case let .failure(error):
                print("faliuress")
            }
            
        }
    }
    
    func getCartTotalMoney(factoryAndUser : CurrentUserFactorys,User_temp_tokens: String ,user_branch_id : String){
        
        let user_temp_tokens: String = User_temp_tokens
       
        
        
        
        let url = "https://m.marsfresh.com/api/factoryCartList"
        let params = ["factory_id":factoryAndUser.id,"user_id":factoryAndUser.user_id,"user_branch_id ": user_branch_id] as [String : Any]
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
                let value = json["result"]
               
                let items_money = value["items_money"].doubleValue
                             
                
                self.cartTotalMoney  =  items_money
  
               
                
//               print(" the cartitems is \(String(describing:  self.currentcart) )")
               
            case let .failure(error):
                print("faliuress")
            }
            
        }
    }
   
  }

