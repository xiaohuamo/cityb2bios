//
//  Purchase.swift
//  CityB2B
//
//  Created by Fei Wang on 4/2/2023.
//

import Foundation


struct Purchase: Codable {
    
    var default_address: Default_address
    var delivery_way: [Delivery_way]
    var pickUpAddressList: [PickUpAddressList]
    var pay_way: [Pay_way]
    var items  : PurchaseInfo
    var promotion_code_list : [Promotion_code_list]?
    var delivery_fee : String? = "0.00"
    var items_money : String? = "0.00"
     
}

struct Default_address: Codable {
    
    var id: Int
    var userId: Int
    var first_name: String?
    var last_name: String?
    var address: String?
    var phone: String?
    
    var email: String?
    var id_number: String?
    var createTime: Int?
    var message_to_business: String?
    
    var country: String?
    var addrPost: String?
    var isDefaultAddress: Int? = 1
    var Street_number: String?
    
             
    var displayName: String?
    var business_hours: String?
    var arrive_mode: String?
    var pic: String?
    
   
}

struct Delivery_way: Codable,Hashable {
    
    var is_default: Int? = 1
    var delivery_option: Int? = 1
    var delivery_option_value: String?
    var delivery_desc: String?

}

struct PickUpAddressList: Codable {
    
    var id: Int? = 0
    var contactPersonNickName: String?
    var googleMap: String?
    var contactMobile: String?
    
    var deliver_avaliable: Int? = 1
    var pickup_avaliable: Int? = 0
    
    var supportofflinepayment: String?
    var delivery_description: String?
    var pickup_des: String?
    var delivery_desc: String?
    
   
             
    
    
}

struct Pay_way: Codable,Hashable{
    
    var payment_option_value: String? = ""
    var is_default: Int? = 0
    var payment: String? = ""
    var pay_way: String? = ""
    var pay_desc: String? = ""
  
}

struct PurchaseInfo: Codable {
        
    var businessUserId: String
    var userId : String
    var businessUserName: String?
    var logo: String?
    var pic: String?
    var items: [PurchaseItemsDetails]?
    var items_count: Int = 0
    var items_money : String?
    var estimate_delivery_fee :String?
    
    
}

struct PurchaseItemsDetails: Codable {
    
    var idd: Int
    var userId : Int
    var businessUserId: Int
    var title: String? = ""
    var num: String? = "1.00"
    
    var price: String? = "0.00"
    var old_price: String? = "0.00"
    var guige_des: String? = ""
    var guige_ids: String? = "0"
    
    var id: String
    var coupon_name_en: String? = ""
    var onSpecial: Int? = 0
    var rm_id: Int? = 0
    
    var menu_pic_100: String? = ""
    var menu_pic: String? = ""
    var bonusType: Int? = 7
    var unit: String? = ""
    
    var item_message: String? = ""
    var menu_id: String? = ""
    var visible: Int? = 1
    var limit_buy_qty: Int? = 999999
   
    var qty: Int? = 999999
    var subtitle: String? = ""
    var menu_name: String? = ""
    var hasGG: Int? = 0
    var item_money :   String? = "0.00"
    
}

extension PurchaseItemsDetails{
    var imageURL: URL {
        URL(string: menu_pic ?? "")!
    }
    var image_100URL: URL {
        URL(string: menu_pic_100 ?? "")!
    }
    
 

}

struct Promotion_code_list: Codable {
    
    var id: Int? = 0
    
   
    
    
}


