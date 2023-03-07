//
//  CategoryViewModel.swift
//  CityB2B
//
//  Created by Fei Wang on 30/1/2023.
//


//
//  OrderViewModel.swift
//  ShoppingApp
//
//  Created by kz on 23/01/2023.
//

import Foundation

import Alamofire
import SwiftyJSON

class ShopCategoryViewModel: ObservableObject {
    
   
    @Published var shopCategory: [ShopCategory]?
    @Published var shopCategories: [ShopCategory] = []

    func getArrayFromJsonString(jsonString:String)->Array<Any> {

                   let jsonData:Data = jsonString.data(using: .utf8)!

                   let array = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)

            if array != nil {

                return array as! Array

            }

            return array as! Array

        }

   
    
    func getShopCategories(factoryAndUser : CurrentUserFactorys,User_temp_tokens: String) {
        self.shopCategory?.removeAll()
        
        self.shopCategory = [ShopCategory]()
        
        
        let url = "https://m.marsfresh.com/api/categoryList"
        let params = ["factory_id":factoryAndUser.id]
                      
        let headers: HTTPHeaders = [
                        "token": User_temp_tokens
                      ]

        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
//            debugPrint(response)
//      debug print 有值
            switch response.result{
                
          
                
            case .success(let value):
                let json = JSON(value)
                let json1 = json["result"]

                
                for (key, value) in json1 {
                    
                    let id = value["id"].stringValue
                    let title = value["title"].stringValue
                    let sort = value["sort"].stringValue
                    let hot = value["hot"].intValue
                    let category_id = value["category_id"].stringValue
                    let subCategoryList = value["subCategoryList"] as? SubCategoryList ?? SubCategoryList.sampleSubCategoryList
                    var item = ShopCategory(sort: sort,id: id,category_id: category_id,  hot: (hot != 0),  subCategoryList:subCategoryList , title: title)

                    self.shopCategory?.append(item)
                    print(key)
//                    print(item)
                    
                }
//                print(" the json numbwer is \(self.shopCategory )")

            case let .failure(error):
                print("faliuress")
            }
            
        }
 
     
    }
    
}
