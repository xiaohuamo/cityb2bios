//
//  Item.swift
//  CityB2B
//
//  Created by Fei Wang on 1/2/2023.
//

import Foundation

struct Item: Identifiable, Codable, Hashable {
    
    var id: Int
    var parent_category_id: String? = "100"
    var sub_category_id: Int?
    var parent_cat_name: String
    
    var sub_cat_name: String?
    var menu_pic: String
    var menu_pic_300: String
    var title: String
    var menu_id: String
    var menu_desc: String
    var unit: String
    
    
    
    
    var onSpecial: Int
    var hasGG: Int?
    var num: Int?
    var old_price: Double?
    var menu_price_fixed: Int?
    
    var grade_menu_price_fixed: String?
    var limit_buy_qty: Int?
    var qty: Int?
    var subtitle: String?
    var price: Double? = 0.00 
    var bought: Int?
    var discount_show: String?
             
  
}

extension Item{
    var imageURL: URL {
        URL(string: menu_pic)!
    }
    var image_300URL: URL {
        URL(string: menu_pic_300)!
    }
    static var sampleItem: Item {
        return Item( id: 4321123, parent_category_id: "322123" , sub_category_id: 32445, parent_cat_name: "chickj", sub_cat_name: "test", menu_pic: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg", menu_pic_300: "https://www.tradeinn.com/f/13745/137457920/apple-macbook-pro-touch-bar-16-i9-2.3-16gb-1tb-ssd-laptop.jpg",title: "chicken breast",menu_id: "c2001",menu_desc: "chicken breast desc desc ",unit: "Kg",
                     onSpecial: 0,hasGG: 0,num: 0,old_price: 2.32,menu_price_fixed: 0,
                     grade_menu_price_fixed: "0",limit_buy_qty: 0,qty: 32222, subtitle: "its a subtitle",price: 2.32,bought: 0,discount_show: "0"
        )
        
      
      
    }
 

}
