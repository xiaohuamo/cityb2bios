//
//  File.swift
//  CityB2B
//
//  Created by Fei Wang on 3/2/2023.
//

import Foundation
struct Cart: Codable {
    
    var businessUserId: String
    var userId : String
    var businessUserName: String?
    var logo: String?
    var pic: String?
    var items: [CartItem]?
    var items_count: Int = 0
    var items_money : String?
    var estimate_delivery_fee :String?
    
    
}

struct CartItem: Codable {
    
    var idd: Int
    var userId : Int
    var businessUserId: Int
    var title: String? = ""
    var num: Int? = 1
    var price: String? = "0.00"
    var old_price: String? = "0.00"
    var guige_des: String? = ""
    var guige_ids: String? = "0"
    var id: String
    var coupon_name_en: String? = ""
    var onSpecial: Int? = 0
    var rm_id: Int? = 0
    var menu_pic_100: String? = "AAA"
    var menu_pic: String? = "AAA"
    
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
    
}

extension CartItem{
    var imageURL: URL {
        URL(string: menu_pic ?? "https://www.marsfresh.com/data/upload/2022-01/20220123180522369470.jpg") ?? URL(string: "https://www.marsfresh.com/data/upload/2022-01/20220123180522369470.jpg" )!
        
    }
    var image_100URL: URL {
        URL(string: menu_pic_100 ?? "https://www.marsfresh.com/data/upload/2022-01/20220123180522369470.jpg")!
    }
    
    static var sampleCartItem: CartItem {
        
          
        return CartItem( idd: 4321123, userId: 2188209 , businessUserId: 319188, title: "chicken breadst 4.5 very very good one ", num: 7, price: "12.50",old_price: "16.50",guige_des:"20cmm diced",guige_ids: "1234", id: "2345",
                     coupon_name_en: "coupon name is ok ",
                     onSpecial:  0,
                     rm_id:0,
                     menu_pic_100:  "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg",
                     menu_pic: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg",
                     
                     bonusType:  7,
                     unit: "KG",
                     item_message: "no any message",
                     menu_id:  "c32003231",
                     visible:  1,
                     limit_buy_qty: 999999,
                     
                     qty:  999999,
                     subtitle: "鸡肉20cmm 去皮去骨",
                     menu_name :"鸡肉20cmm 去皮去骨",
                     hasGG:  0
                     
                     
                     
        )
        
        
        
    }
    
}

