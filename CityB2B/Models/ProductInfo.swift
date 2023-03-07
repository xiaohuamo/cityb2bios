//
//  ProductInfo.swift
//  CityB2B
//
//  Created by Fei Wang on 19/2/2023.
//

import Foundation
struct ProductInfo:  Codable {
    
    
    /*
     "id": 385892,
     "parent_category_id": 38532,
     "sub_category_id": 0,
     "parent_cat_name": "Chicken",
     "sub_cat_name": null,
     "menu_pic": "https:\/\/www.marsfresh.com\/data\/upload\/thumbnails\/2022-02\/20220227145607222153_100x100_fill.jpg",
     "menu_pic_300": "thumbnails\/2022-02\/20220227145607222153_300x300_fill.jpg",
     "title": "Whole Bird （CTN)",
     "menu_id": "C0050",
     "menu_desc": "Whole Bird （CTN)",
     "unit": "CTN",
     "onSpecial": 0,
     "hasGG": 1,
     "num": 0,
     "old_price": 135,
     "menu_price_fixed": null,
     "grade_menu_price_fixed": null,
     "limit_buy_qty": 0,
     "qty": 999024,
     "menu_pics": ["https:\/\/www.marsfresh.com\/data\/upload\/2022-02\/20220227145607222153.jpg"],
     "content": "",
     "subtitle": "",
     "cover_pic": "https:\/\/www.marsfresh.com\/data\/upload\/2022-02\/20220227145607222153.jpg",
     "price": 135,
     "bought": 1,
     "guige_des1": {
     "id": 550,
     "category_name": "Whole Bird(CTN)"
     },
     "menu_option_list": [{
     "id": 2951,
     "menu_pic": "",
     "price": 135,
     "menu_desc": "Size 9 About 12ea",
     "old_price": 135,
     "menu_name": "Size 9",
     "islastBought": 0,
     "islastBought_desc": "",
     "num": 0
     }, {
     "id": 2952,
     "menu_pic": "",
     "price": 135,
     "menu_desc": "Size 10 About 12ea",
     "old_price": 135,
     "menu_name": "Size 10",
     "islastBought": 1,
     "islastBought_desc": "Bought",
     "num": 0
     }, {
     "id": 2953,
     "menu_pic": "",
     "price": 135,
     "menu_desc": "Size 12 About 10ea",
     "old_price": 135,
     "menu_name": "Size 12",
     "islastBought": 0,
     "islastBought_desc": "",
     "num": 0
     }, {
     "id": 2954,
     "menu_pic": "",
     "price": 135,
     "menu_desc": "Size 14 About 10ea",
     "old_price": 135,
     "menu_name": "Size 14",
     "islastBought": 0,
     "islastBought_desc": "",
     "num": 0
     }, {
     "id": 2955,
     "menu_pic": "",
     "price": 135,
     "menu_desc": "Size 16 About 8ea",
     "old_price": 135,
     "menu_name": "Size 16",
     "islastBought": 0,
     "islastBought_desc": "",
     "num": 0
     }, {
     "id": 2956,
     "menu_pic": "",
     "price": 135,
     "menu_desc": "Size 18 About 8ea",
     "old_price": 135,
     "menu_name": "Size 18",
     "islastBought": 0,
     "islastBought_desc": "",
     "num": 0
     }],
     "discount_show": ""
     }
     }
     */
    
    
    var id: Int
    var parent_category_id: Int
    var sub_category_id: Int? = 0
    var parent_cat_name: String?
    var sub_cat_name: String?
    var menu_pic: String? = ""
    var menu_pic_300: String? = ""
    var title: String? = ""
    var menu_id: String? = ""
    var menu_desc: String? = ""
    var unit: String? = ""
    var onSpecial: Int = 0
    var hasGG: Int = 0
    var num: Int = 0
    var old_price: Double = 0.00
    var menu_price_fixed: Int = 0
    var grade_menu_price_fixed: Int = 0
    var limit_buy_qty: Int = 0
    var qty: Int = 0
    var menu_pics: [String]?
    var content: String? = ""
    var subtitle: String? = ""
    var cover_pic: String? = ""
    var price: Double = 0.00
    var bought: Int = 0
    var guige_des1 : GuigeDesc1?
    var menu_option_list : [MenuOptionList]?
    var discount_show : String? = ""
    
}


struct GuigeDesc1 : Codable  {
    var id :Int? = 0
    var category_name  :String  = ""
}


struct  MenuOptionList : Codable ,Hashable {
    var id :Int? = 0
    var menu_pic :String  = ""
    var price :Double  = 0.00
    var menu_desc :String  = ""
    var old_price :Double  = 0.00
    var menu_name :String  = ""
    var islastBought :Int  =  0
    var islastBought_desc :String  = ""
    var num :Int =  0
    
}


extension ProductInfo{
    var imageURL: URL {
        URL(string: menu_pic ?? "")!
    }
    var image_300URL: URL {
        URL(string: menu_pic_300 ?? "")!
    }
    static var sampleProductInfo: ProductInfo {
        return ProductInfo(
            id: 385785,
            parent_category_id: 38532,
            sub_category_id: 40687,
            parent_cat_name: "Chicken",
            sub_cat_name: "Chicken Diced",
            menu_pic: "https://www.marsfresh.com/data/upload/thumbnails/2022-01/20220123180522369470_150x150_fill.jpg",
            menu_pic_300: "thumbnails/2022-01/20220123180522369470_300x300_fill.jpg",
            title: "TF Skinless Diced",
            menu_id: "C0019",
            menu_desc: "Thigh Fillet Skinless Diced",
            unit: "kg",
            onSpecial: 0,
            hasGG: 1,
            num: 0,
            old_price: 14,
            menu_price_fixed : 0,
            grade_menu_price_fixed: 0,
            limit_buy_qty: 0,
            qty: 997423,
            menu_pics: ["https://www.marsfresh.com/data/upload/2022-01/20220123180522369470.jpg","https://www.marsfresh.com/data/upload/2022-01/20220123180522369470.jpg"],
            content: "",
            subtitle: "",
            cover_pic: "https://www.marsfresh.com/data/upload/2022-01/20220123180522369470.jpg",
            price: 14,
            bought: 0,
            guige_des1: GuigeDesc1(id: 505,
                                   category_name: "TF Diced")
            
            ,
            menu_option_list: [
                MenuOptionList( id: 651, menu_pic: "",
                                price: 14,
                                menu_desc: "",
                                old_price: 14,
                                menu_name: "10 Ctens",
                                islastBought: 0,
                                islastBought_desc: "",
                                num: 0),
                MenuOptionList( id: 652,
                                menu_pic: "",
                                price: 14,
                                menu_desc: "",
                                old_price: 14,
                                menu_name: "20 Ctens w",
                                islastBought: 0,
                                islastBought_desc: "",
                                num: 0),
                MenuOptionList( id: 653, menu_pic: "", price: 14, menu_desc: "", old_price: 14, menu_name: "30 Ctens rewee ee",  islastBought: 0,islastBought_desc: "", num: 0)
                ,
MenuOptionList( id: 654, menu_pic: "", price: 14, menu_desc: "", old_price: 14, menu_name: "40 Ctens is missing",  islastBought: 0,islastBought_desc: "", num: 0)
                ,
MenuOptionList( id: 655, menu_pic: "", price: 14, menu_desc: "", old_price: 14, menu_name: "50 Ctens big big",  islastBought: 0,islastBought_desc: "", num: 0)
                ,
MenuOptionList( id: 656, menu_pic: "", price: 14, menu_desc: "", old_price: 14, menu_name: "30 Ctens",  islastBought: 0,islastBought_desc: "", num: 0)
            ], discount_show: ""
         )
    }
     
}

