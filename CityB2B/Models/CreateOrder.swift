//
//  CreateOrder.swift
//  CityB2B
//
//  Created by Fei Wang on 8/2/2023.
//

import Foundation
struct CreateOrder: Codable {
    
    var factory_id: Int
    var user_id: Int
    var user_branch_id: Int? = 0
    var logistic_delivery_date: Int? = 0
    var delivery_option: Int? = 0
    
    var payment: String? = "offline"
    var address_id: Int? = 0
    var business_staff_id: Int? = 0
    
    var items:  [CreateOrderItems]?
    
    
    var promotion_id: Int? = 0
    var promotion_amount: Float? = 0.00
    var coupon_id: Int? = 0
    var coupon_amount : Float? = 0.00
//    接口的地方是number 数据类型
    var delivery_fee :  Double = 0.00
    var total_money : Double = 0.00
    var is_combine_order : Int = 0
    var message_to_business : String = ""
   
    
}

extension CreateOrder{
    var logistic_delivery_date_desc: String {
        
        let  interval:TimeInterval=TimeInterval.init(String(logistic_delivery_date ?? 0))!

              let date = Date(timeIntervalSince1970: interval)

              let dateformatter = DateFormatter()

               //自定义日期格式

              dateformatter.dateFormat = "yyyy-MM-dd"

              let strdate =  dateformatter.string(from: date)
        
        
        
           let days = Int(interval/86400) // 24*60*60
           let weekday = ((days + 4)%7+7)%7
        
       
          weekday == 0 ? 7 : weekday
        return  strdate + " " + self.getweekdays(Weekday: weekday)
        
       
    
    }
    var delivery_option_desc : String {
        if(delivery_option == 1) {
            return "seller delivery xxx"
        }else{
            return "cusomer pickup  xxx"
        }
    }
 

    func getweekdays(Weekday :Int)->String{
        
        switch Weekday {
        case 1:
            return "Mon"
        case 2:
            return "Tue"
        case 3:
            return "Wed"
        case 4:
            return "Thur"
        case 5:
            return "Fri"
        case 6:
            return "Sat"
        case 7:
            return "Sun"
            
        default:
            return "Sun"
        }
        
    }

}

// 发送订单的产品明细 其中id 为临时购物车id
struct CreateOrderItems: Codable {
    var id: Int
    var quantity : String
    
}
