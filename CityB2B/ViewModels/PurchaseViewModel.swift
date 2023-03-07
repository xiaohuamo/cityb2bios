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

class PurchaseViewModel: ObservableObject {
    
   
    
   
    @Published var purchaseInfo: Purchase?
    
    @Published var currentDeliverOption: Int? = 1
    @Published var currentDeliverOptionValue: String? = "Seller Delivery "
    @Published var currentDeliverOptionDesc: String? = " "
    
   
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
   
   
//    get the default delivery option value  1 : delivery  2 : pick up
    func getDefaultDelieryOptionValue() ->Delivery_way {
        var retDeliveryOptionvalue :Delivery_way?
        if purchaseInfo != nil {
            let delivery_way : [Delivery_way] = self.purchaseInfo!.delivery_way
            for i in 0..<(delivery_way.count ?? 0)  {
              
                if delivery_way[i].is_default == 1  {
                    retDeliveryOptionvalue = delivery_way[i]
                }
                
            }
        }
        return retDeliveryOptionvalue!
    }
   
    func getPurchaseInfo(factoryAndUser : CurrentUserFactorys,User_temp_tokens: String,user_branch_id : String){
        
        let user_temp_tokens: String = User_temp_tokens
      
//     self.purchaseInfo = nil
         let url = "https://m.marsfresh.com/api/showCartInfo"
        let params = ["factory_id":factoryAndUser.id,"user_id":factoryAndUser.user_id,"user_branch_id ":  "0"] as [String : Any]
        let headers: HTTPHeaders = [
                        "token": user_temp_tokens
                      ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            
            print(" the delviery date infor  is \(response.result)")
debugPrint(response)
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let value1 = json["result"]
               
             
                
                let default_address = self.setDefault_address(value: value1["default_address"])
                
                let delivery_way = self.setDelivery_way(value: value1["delivery_way"])
                
                let pickUpAddressList = self.setPickUpAddressList(value: value1["pickUpAddressList"])
                
                let pay_way = self.setPay_way(value: value1["pay_way"])
                
                let items  = self.setItems(value: value1["items"])
                
                
                
               print(" the purchase info is \(String(describing:  items) )")
                let promotion_code_list = self.setPromotion_code_list(value: value1["promotion_code_list"])
                let delivery_fee = value1["delivery_fee"].stringValue
                let items_money = value1["items_money"].stringValue
                
                self.purchaseInfo =  Purchase(default_address: default_address,delivery_way: delivery_way,pickUpAddressList: pickUpAddressList,pay_way: pay_way,items: items,promotion_code_list: promotion_code_list,delivery_fee: delivery_fee,items_money: items_money)
                
//                print(" the purchase info is \(String(describing:  self.purchaseInfo) )")
 
               
               
            case let .failure(error):
                print("Failure when do method getPurchaseInfo at PruchasedViewModel :  \(error)")
            }
            
        }
    }
    
   
    func setPromotion_code_list( value :JSON ) -> [Promotion_code_list] {
        var d_way : Promotion_code_list
        var d_ways = [Promotion_code_list]()
        
        for (_, value1) in value {
            
             let id = value1["id"].intValue
           
            
               
            d_way = Promotion_code_list(id:id)
            
            d_ways.append(d_way)
            
        }
         
        return d_ways
        
    }
    
    
    
    func setPurchaseItemsDetailsvalue( value :JSON ) -> [PurchaseItemsDetails] {
        var d_way : PurchaseItemsDetails
        var d_ways = [PurchaseItemsDetails]()
        
        for (_, value1) in value {
            
          
            var idd = value1["idd"].intValue
            var userId = value1["userId"].intValue
            var businessUserId = value1["businessUserId"].intValue
            var title = value1["title"].stringValue
            var num = value1["num"].stringValue
            
            var price = value1["price"].stringValue
            var old_price = value1["old_price"].stringValue
            var guige_des = value1["guige_des"].stringValue
            var guige_ids = value1["guige_ids"].stringValue
            
            
            var id = value1["id"].stringValue
            var coupon_name_en = value1["coupon_name_en"].stringValue
            var onSpecial = value1["onSpecial"].intValue
            var rm_id = value1["rm_id"].intValue
            
            var menu_pic_100 = value1["menu_pic_100"].stringValue
            var menu_pic = value1["menu_pic"].stringValue
            var bonusType = value1["bonusType"].intValue
            var unit = value1["unit"].stringValue
            
         
            var item_message = value1["item_message"].stringValue
            var menu_id = value1["menu_id"].stringValue
            var visible = value1["visible"].intValue
            var limit_buy_qty = value1["limit_buy_qty"].intValue
         
            var qty = value1["qty"].intValue
            var subtitle = value1["subtitle"].stringValue
            var menu_name = value1["menu_name"].stringValue
            var hasGG = value1["hasGG"].intValue
            var item_money = value1["item_money"].stringValue
            
            d_way = PurchaseItemsDetails(idd:idd,userId:userId,businessUserId:businessUserId,title:title,num:num,price:price,old_price:old_price,guige_des:guige_des,guige_ids:guige_ids,id:id,coupon_name_en:coupon_name_en,onSpecial:onSpecial,rm_id:rm_id,menu_pic_100:menu_pic_100,menu_pic:menu_pic,bonusType:bonusType,unit:unit,item_message:item_message,menu_id:menu_id,visible:visible,limit_buy_qty:limit_buy_qty,qty:qty,subtitle:subtitle,menu_name:menu_name,hasGG:hasGG,item_money:item_money)
            
            d_ways.append(d_way)
            
        }
         
        return d_ways
        
    }
    
    
    
    
    
    func setItems( value :JSON ) -> PurchaseInfo {
        var d_way : PurchaseInfo
   
        let businessUserId = value[0]["businessUserId"].stringValue
        let userId = value[0]["userId"].stringValue
        let businessUserName = value[0]["businessUserName"].stringValue
        let logo = value[0]["logo"].stringValue
        let pic = value[0]["pic"].stringValue
        let items = self.setPurchaseItemsDetailsvalue(value: value[0]["items"])
     
        let items_count = value[0]["items_count"].intValue
        let items_money = value[0]["items_money"].stringValue
        let estimate_delivery_fee = value[0]["estimate_delivery_fee"].stringValue
        
        
               
        d_way = PurchaseInfo(businessUserId:businessUserId,userId:userId,businessUserName:businessUserName,logo:logo,pic:pic,items:items,items_count:items_count,items_money:items_money,estimate_delivery_fee:estimate_delivery_fee)
            
          
        
         
        return d_way
        
    }
    
    
     
    func setPay_way( value :JSON ) -> [Pay_way] {
        var d_way : Pay_way
        var d_ways = [Pay_way]()
        
        for (_, value1) in value {
            
             var payment_option_value = value1["payment_option_value"].stringValue
            var is_default = value1["is_default"].intValue
           
            var payment = value1["payment"].stringValue
            var pay_way = value1["pay_way"].stringValue
            var pay_desc = value1["pay_desc"].stringValue
            
               
            d_way = Pay_way(payment_option_value:payment_option_value,is_default:is_default,payment:payment,pay_way:pay_way,pay_desc:pay_desc)
            
            d_ways.append(d_way)
            
        }
         
        return d_ways
        
    }
    
    
    
     
    func setPickUpAddressList( value :JSON ) -> [PickUpAddressList] {
        var d_way : PickUpAddressList
        var d_ways = [PickUpAddressList]()
        
        for (_, value1) in value {
            
            
            var id = value1["id"].intValue
            var contactPersonNickName = value1["contactPersonNickName"].stringValue
            var googleMap = value1["googleMap"].stringValue
            var contactMobile = value1["contactMobile"].stringValue
            var deliver_avaliable = value1["deliver_avaliable"].intValue
            
            var pickup_avaliable = value1["pickup_avaliable"].intValue
            var delivery_description = value1["delivery_description"].stringValue
            var pickup_des = value1["pickup_des"].stringValue
            var delivery_desc = value1["delivery_desc"].stringValue
            
            
             
            d_way = PickUpAddressList(id:id,contactPersonNickName:contactPersonNickName,googleMap:googleMap,contactMobile:contactMobile,deliver_avaliable:deliver_avaliable,pickup_avaliable:pickup_avaliable,delivery_description:delivery_description,pickup_des:pickup_des,delivery_desc:delivery_desc)
            
            d_ways.append(d_way)
            
        }
         
        return d_ways
        
    }
    
    
    
     
    func setDelivery_way( value :JSON ) -> [Delivery_way] {
        var d_way : Delivery_way
        var d_ways = [Delivery_way]()
        
        for (_, value1) in value {
            
            var is_default = value1["is_default"].intValue
            var delivery_option = value1["delivery_option"].intValue
            
            var delivery_option_value = value1["delivery_option_value"].stringValue
            var delivery_desc = value1["delivery_desc"].stringValue
            
            d_way = Delivery_way(is_default:is_default,delivery_option:delivery_option,delivery_option_value:delivery_option_value,delivery_desc:delivery_desc)
            
            d_ways.append(d_way)
            
        }
        
        return d_ways
        
    }
   
    
    func setDefault_address( value :JSON ) -> Default_address {
        var d_address : Default_address
        
        let id = value["id"].intValue
        let userId = value["userId"].intValue
        
        let first_name = value["first_name"].stringValue
        let last_name = value["last_name"].stringValue
        let address = value["address"].stringValue
        let phone = value["phone"].stringValue
        
        let email = value["email"].stringValue
        let id_number = value["id_number"].stringValue
        let createTime = value["createTime"].intValue
        let message_to_business = value["message_to_business"].stringValue
  
        let country = value["country"].stringValue
        let addrPost = value["addrPost"].stringValue
        let isDefaultAddress = value["isDefaultAddress"].intValue
        let Street_number = value["Street_number"].stringValue
      
        
        let displayName = value["displayName"].stringValue
        let business_hours = value["business_hours"].stringValue
        let arrive_mode = value["arrive_mode"].stringValue
        let pic = value["pic"].stringValue
      
        d_address = Default_address(id:id,userId:userId,first_name:first_name,last_name:last_name,address:address,phone:phone,email:email,id_number:id_number,createTime:createTime,message_to_business:message_to_business,country:country,addrPost:addrPost,isDefaultAddress:isDefaultAddress,Street_number:Street_number,displayName:displayName,business_hours:business_hours,arrive_mode:arrive_mode,pic:pic)
        
        return d_address
        
    }
   
  }

