//
//  DeliveryDate.swift
//  CityB2B
//
//  Created by Fei Wang on 8/2/2023.
//

import Foundation
struct DeliveryDate: Codable ,Hashable {
    
    
    /* 获取配送日程接口 
     {
             "delivery_morning": null,
             "delivery_afternoon": null,
             "delivery_anytime": null,
             "orderStartTimestamp": null,
             "orderEndTimestamp": null,
             "orderDeliveryTimestamp": 1675728000,
             "orderStart": null,
             "orderEnd": null,
             "orderDelivery": null,
             "isAvaliable": false,
             "isselected": 0,
             "days": "TUE",
             "disPlayDate": "07-Feb",
             "optionalDisplay": "No Delivery"
         }
     
     */
    
    var  delivery_morning :Int? = 0
    var  delivery_afternoon :Int? = 0
    var  delivery_anytime :Int? = 1
    
    var  orderStartTimestamp :Int? = 0
    var  orderEndTimestamp :Int? = 0
    var  orderDeliveryTimestamp :Int? = 0
    
    var  orderStart :String? = ""
    var  orderEnd :String? = ""
    var  orderDelivery :String? = ""    
    var  isAvaliable :Bool? = false
    var  isselected :Int? = 0
    var  days :String? = ""
    var  disPlayDate :String? = ""
    var  optionalDisplay :String? = ""
    var  backColor :String? = ""
  
  
    
}
