//
//  DeliveryDateText.swift
//  CityB2B
//
//  Created by Fei Wang on 8/2/2023.
//



import Foundation
struct DeliveryDateText: Codable ,Hashable {
    
    /* 获取下单时间及配送时间接口
     {
             "id": 557,
             "centre_business_id": 319188,
             "business_id": 319188,
         
             "business_name": "",
             "business_name_en": "",
             "delivery_date_of_week": "MON",
             "delivery_anytime": 1,
             "delivery_morning": 0,
             "delivery_afternoon": 0,
             "enable": 1,
             "order_start_of_date": "TUE",
             "order_start_of_time": "04:00",
             "order_cut_of_date": "SUN",
             "order_cut_of_time": "23:00",
             "ordertime": "From TUE 04:00 To SUN 23:00"
         }
     */
    var  id :Int? = 0
    var  centre_business_id :Int? = 0
    var  business_id :Int? = 0
    
    var  business_name :String? = ""
    var  business_name_en :String? = ""
    var  delivery_date_of_week :String? = ""
    var  delivery_anytime :Int? = 1
    var  delivery_morning :Int? = 0
    var  delivery_afternoon :Int? = 0
    var  enable :Int? = 1
   
    var  order_start_of_date :String? = ""
    var  order_start_of_time :String? = ""
    var  order_cut_of_date :String? = ""
    var  order_cut_of_time :String? = ""
    var  ordertime :String? = ""
    
}
