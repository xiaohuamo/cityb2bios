//
//  HomePageInfo.swift
//  CityB2B
//
//  Created by Fei Wang on 15/2/2023.
//

import Foundation
struct HomePageInfo: Codable {
    
    var is_has_suppliers: Int = 0
    var is_has_supillers_match = 0
    var suppliers_goods : [Suppliers_goods]
 
}

struct Suppliers_goods: Identifiable, Codable {
   var id : Int = 0 
   var cate: CurrentuserCate
   var factory : [CurrentUserFactorys ]
  
 
}

struct CurrentuserCate: Codable {
    
    var id: String? = ""
    var name: String? = ""
    var name_en: String? = ""
    var alias: String? = ""
    var imageUrl: String? = ""
  
}

struct CurrentUserFactorys: Codable,Identifiable,Equatable,Hashable {
    
    var id: Int
    var user_id: Int
    var logo: String = ""
    var displayName: String = ""
    var phone: String = ""
    var googleMap: String = ""
    var business_nick_name: String = ""
    var business_note: String = ""
    var pic: String = ""
                   
}


extension CurrentUserFactorys{
    var imageURL: URL {
        URL(string: pic)!
    }
    var logoURL: URL {
        URL(string: logo)!
    }
   


}
