//
//  Category.swift
//  CityB2B
//
//  Created by Fei Wang on 30/1/2023.
//

import Foundation
struct ShopCategory: Identifiable, Codable, Hashable {
    var sort: String
    var id: String
    var category_id: String
    var hot : Bool
    var subCategoryList : SubCategoryList
   
    var title : String
}

struct SubCategoryList: Identifiable, Codable, Hashable  {
    var hot : Bool?
    var category_id: String?
    var sort: String?
    var id: String?
    var title : String?
}


extension SubCategoryList{
    
    static var sampleSubCategoryList: SubCategoryList {
        return SubCategoryList(hot: false, category_id: "0" , sort: "111",  id: "111", title: "test")
    }


}



