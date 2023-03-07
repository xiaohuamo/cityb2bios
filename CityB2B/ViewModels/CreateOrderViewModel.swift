//
//  CreateOrderViewModel.swift
//  CityB2B
//
//  Created by Fei Wang on 8/2/2023.
//  存储提交订单的信息，即提交订单

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class CreateOrderViewModel: ObservableObject {
    
    @EnvironmentObject var user: UserViewModel
    
    @EnvironmentObject var purchaseVM: PurchaseViewModel
        
    @Published var createOrder: CreateOrder?
    
    
    
//    @Published var user_temp_tokens: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjaXR5YjJiX21lbWJlcl9zeXN0ZW1faXNzIiwiYXVkIjoiY2l0eWIyYl9tZW1iZXJfc3lzdGVtX2F1ZCIsImlhdCI6MTY3NTA1OTk5MiwibmJmIjoxNjc1MDU5OTkyLCJleHAiOjE2Nzc2NTE5OTIsImRhdGEiOnsidWlkIjoyMTg4MTcxLCJidXNpbmVzc0lkIjowfX0.zcshlfh8pKVecMEHlUw3RA3ybkld5tZRdCPZVH5rjkA"
   
   
    //ALERTS
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var showingConfirm : Bool = false
    
    @Published var orderSuccessful : Bool = false
    
    
    
    
//    生成订单
    
    func submitOrder(AuthUser: UserViewModel ,CreateOrderInfo : CreateOrder){
//        print(" default is \(self.purchaseVM.purchaseInfo?.default_address)")
        //        print("ererwerer")
        let user_temp_tokens: String = AuthUser.user_temp_tokens
        
//        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJjaXR5YjJiX21lbWJlcl9zeXN0ZW1faXNzIiwiYXVkIjoiY2l0eWIyYl9tZW1iZXJfc3lzdGVtX2F1ZCIsImlhdCI6MTY3NTA1OTk5MiwibmJmIjoxNjc1MDU5OTkyLCJleHAiOjE2Nzc2NTE5OTIsImRhdGEiOnsidWlkIjoyMTg4MTcxLCJidXNpbmVzc0lkIjowfX0.zcshlfh8pKVecMEHlUw3RA3ybkld5tZRdCPZVH5rjkA"
        
        let url = "https://m.marsfresh.com/api/createOrder"
        
        
        
        var items = [[String:Any] ]()
        
        var item = [String:Any] ()
        
//        var elementdetail = (String,Any).self
        
        for i in 0 ..< (CreateOrderInfo.items?.count ?? 0) {
//            elementdetail = ("id",CreateOrderInfo.items![i].id as Any)
            item = ["id":CreateOrderInfo.items?[i].id as Any,"quantity":CreateOrderInfo.items?[i].quantity ?? 1]
            items.append(item)
//            items.append(CreateOrderInfo.items![i])
        }
        
         print("here is items \(items)")
     
        let params = ["factory_id":CreateOrderInfo.factory_id,"user_id":CreateOrderInfo.user_id,"user_branch_id ":  CreateOrderInfo.user_branch_id ?? 0,"logistic_delivery_date" : CreateOrderInfo.logistic_delivery_date!,"delivery_option":CreateOrderInfo.delivery_option ?? 1,"payment":CreateOrderInfo.payment!,"address_id":CreateOrderInfo.address_id ?? 1
                      ,"business_staff_id":CreateOrderInfo.business_staff_id ?? 0,"items": items ,"promotion_id":CreateOrderInfo.promotion_id ?? "0","promotion_amount":CreateOrderInfo.promotion_amount ?? 0.00,"coupon_id":CreateOrderInfo.coupon_id ?? 0,"coupon_amount":CreateOrderInfo.coupon_amount ?? 0 ,"delivery_fee":CreateOrderInfo.delivery_fee,"total_money":CreateOrderInfo.total_money,"is_combine_order":CreateOrderInfo.is_combine_order,"message_to_business":CreateOrderInfo.message_to_business] as [String : Any]
        
        
        
        
  /*      let params1 = ["promotion_amount": 0.0, "message_to_business": "", "promotion_id": 0, "delivery_fee": 0.0, "user_id": 2188172, "factory_id": 319188, "coupon_id": 0, "is_combine_order": 0, "delivery_option": 1, "user_branch_id ": 0, "business_staff_id": 0, "items":
                        [["id": 228249, "quantity": "1.00"],["id": 228250, "quantity": "1.00"]]
, "address_id": 18889, "coupon_amount": 0.0, "payment": "offline", "logistic_delivery_date": 1676419200, "total_money": 37.0] as [String : Any]
                                                                                             */
        let headers: HTTPHeaders = [
            "token": user_temp_tokens
        ]
//        let enc = URLEncoding(arrayEncoding: .noBrackets)
        print(" the delviery date infor  is \(params)")
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default, headers: headers).responseData { [self]  response in
            print(" the delviery date infor  is \(response.result)")
          
            debugPrint(response)
            
//            print(" the response status is \(response.result["status"])")
                switch response.result{
                    
              
            case .success(let value):
                
                
                print("success")
                let json = JSON(value)
                let statuscode = json["status"].intValue
                let message = json["message"]
                
                if (statuscode != 200 && statuscode > 0 ) {
                    if(statuscode == 147 ) {
                        if( message != nil) {
                            alertMessage = message.rawValue as! String
                            alertTitle = "是否合单？"
                            showingConfirm = true
                        }
                        
                    }else{
                        if( message != nil) {
                            alertMessage = message.rawValue as! String
                            alertTitle = "提示"
                            showingAlert = true
                        }
                    }
                   
                   
                    
                }else{
//                    下单成功
                    self.orderSuccessful = true
                    
                }
                let json1 = json["result"]
                print(" the delviery date infor  is \(statuscode)")
                
            case let .failure(error):
                print("faliuress")
            }
            
        }
    }
    
    
    
    
    
    
//    设置购买明细信息
    func setItemsInfo(OrderItems: [PurchaseItemsDetails]){
      
        var itemRecords = [CreateOrderItems]()
        
        for i in 0..<(OrderItems.count ?? 0)  {
            let id :Int = OrderItems[i].idd
            let quantity : String = OrderItems[i].num!
            
            var itemRecord = CreateOrderItems(id:id,quantity:quantity)
           
            
            itemRecords.append(itemRecord)
             
        }
        self.createOrder?.items = itemRecords
         
    }
    
    
    func setDeliveryOption(DeliveryOPtion: Int ) {
        
        self.createOrder?.delivery_option = DeliveryOPtion
    }
    
    
    func getCreateOrderInitData(factoryAndUser : CurrentUserFactorys,user_branch_id : String,logistic_delivery_date : Int){
        
        
        
        self.createOrder = nil
        
        let factory_id = Int(factoryAndUser.id)
        let user_id = Int(factoryAndUser.user_id)
        let user_branch_id  = Int(user_branch_id) ?? 0
        let logistic_delivery_date = logistic_delivery_date
        let delivery_option: Int? = 0
        
        let payment: String? = ""
        let address_id: Int? = 0
        let business_staff_id: Int? = 0
        
        let items = [CreateOrderItems(id: 4322,quantity: "2.25"),CreateOrderItems(id: 43223,quantity: "3.25")
        
        ]
        
        
        let promotion_id: Int? = 0
        let promotion_amount: Float? = 0.00
        let coupon_id: Int? = 0
        let coupon_amount : Float? = 0.00
    //    接口的地方是number 数据类型
        let delivery_fee :  Double = 0.00
        let total_money : Double = 0.00
        let is_combine_order : Int = 0
        let message_to_business : String = ""
        
        
        
        self.createOrder =  CreateOrder(factory_id:factory_id,user_id:user_id,user_branch_id:user_branch_id,logistic_delivery_date:logistic_delivery_date,delivery_option:delivery_option,payment:payment,address_id:address_id,business_staff_id:business_staff_id,items:items,promotion_id:promotion_id,promotion_amount:promotion_amount,coupon_id:coupon_id,coupon_amount:coupon_amount,delivery_fee:delivery_fee,total_money:total_money,is_combine_order:is_combine_order,message_to_business:message_to_business)
        
        
        
    }
//    获取当前默认的配送日期
    
   
    
}

