//
//  DeliveryDateViewModel.swift
//  CityB2B
//
//  Created by Fei Wang on 8/2/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON
import Alamofire

class DeliveryDateViewModel: ObservableObject {
    
  
    
    @Published var deliveryDate: [DeliveryDate]?
    @Published var deliveryDate1: [DeliveryDate]?
    
  
    
  
    
    //ALERTS
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    
    func getCurrentSelectedDeliveryDate()->Int{
        var returnvalue : Int = 0
        for i in 0..<(self.deliveryDate?.count ?? 0)  {
            
            if(self.deliveryDate?[i].isselected == 1) {
                returnvalue = self.deliveryDate?[i].orderDeliveryTimestamp ?? 0
            }
        }
        
        for i in 0..<(self.deliveryDate1?.count ?? 0)  {
            if(self.deliveryDate1?[i].isselected == 1) {
                returnvalue =  self.deliveryDate?[i].orderDeliveryTimestamp ?? 0
            }
        }
        return returnvalue
        
    }
    
    func resetAllselectedDeliveryDate(OrderDeliveryTimestamp : Int){
        
        for i in 0..<(self.deliveryDate?.count ?? 0)  {
            if(self.deliveryDate?[i].orderDeliveryTimestamp == OrderDeliveryTimestamp){
                self.deliveryDate?[i].isselected = 1
            }else{
                self.deliveryDate?[i].isselected = 0
            }
           
        }
        
        for i in 0..<(self.deliveryDate1?.count ?? 0)  {
            
            if(self.deliveryDate1?[i].orderDeliveryTimestamp == OrderDeliveryTimestamp){
                self.deliveryDate1?[i].isselected = 1
            }else{
                self.deliveryDate1?[i].isselected = 0
            }
            
          
        }
        
    }
    
    
    func getDeliveryDate(factoryAndUser : CurrentUserFactorys,User_temp_tokens: String,user_branch_id : String) {
        
        let user_temp_tokens: String = User_temp_tokens
        
       
        var isRecordFirstAvaliableDate : Bool = false
        var isSetDefaultDate :Bool = false
      
        
        self.deliveryDate = [DeliveryDate]()
        self.deliveryDate1 = [DeliveryDate]()
        
        let url = "https://m.marsfresh.com/api/deliveryDate"
        let params = ["factory_id":factoryAndUser.id,"user_id":factoryAndUser.user_id,"user_branch_id ":  "0"] as [String : Any]
        
        let headers: HTTPHeaders = [
            "token": user_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            //            debugPrint(response)
            //      debug print 有值
            switch response.result {
                
                
            case .success(let value):
                let json = JSON(value)
                let json1 = json["result"]
                print(" the delviery date infor  is \(json1)")
                
//                 获得当前的日期列表中，是否有默认的日期，如果没有，则选择第一个可用日期。
                for (key, value) in json1 {
                    let isselected = value["isselected"].intValue
                    if (isselected == 1 ) {
                      
                        isSetDefaultDate = true
                    }
                }
                
                
                for (key, value) in json1 {
                    
                     
                    let delivery_morning = value["delivery_morning"].intValue
                    let delivery_afternoon = value["delivery_afternoon"].intValue
                    let delivery_anytime = value["delivery_anytime"].intValue
                    
                    let orderStartTimestamp = value["orderStartTimestamp"].intValue
                    let orderEndTimestamp = value["orderEndTimestamp"].intValue
                    let orderDeliveryTimestamp = value["orderDeliveryTimestamp"].intValue
                    
                   
                    let orderStart = value["orderStart"].stringValue
                    let orderEnd = value["orderEnd"].stringValue
                    let orderDelivery = value["orderDelivery"].stringValue
                    let isAvaliable = value["isAvaliable"].boolValue
                    
//                     如果当前 还没有记录第一个avaiable date ,    且当前的记录状态位 is avalble
//                    当前商家的配送日期中没有默认被选择的日期，且当前是第一个avaliable date ,则设置为 selected = 1
                    var isselected :Int = 0
                    if( isSetDefaultDate == false && isAvaliable == true  && isRecordFirstAvaliableDate == false ){
                        isRecordFirstAvaliableDate = true
                        
                         isselected = 1
                      
                        
                    }else{
                         isselected = value["isselected"].intValue
                    }
                    
                     
                    let days = value["days"].stringValue
                    let disPlayDate = value["disPlayDate"].stringValue
                    let optionalDisplay = value["optionalDisplay"].stringValue
                    
                    var backColor :String = ""
                    if(value["isselected"].intValue == 1 ) {
                        backColor = "mainBlue"
                    }else{
                        if(value["isAvaliable"].boolValue == true) {
                             backColor = "green1"
                        }else{
                             backColor = "grey1"
                        }
                    }
                     var deliverydate1 = DeliveryDate(delivery_morning:delivery_morning,delivery_afternoon:delivery_afternoon,delivery_anytime:delivery_anytime,orderStartTimestamp:orderStartTimestamp,orderEndTimestamp:orderEndTimestamp,orderDeliveryTimestamp:orderDeliveryTimestamp,orderStart:orderStart,orderEnd:orderEnd,orderDelivery:orderDelivery,isAvaliable:isAvaliable,isselected:isselected,days:days,disPlayDate:disPlayDate,optionalDisplay:optionalDisplay,backColor:backColor)
                     
                    if(Int(key)! < 4) {
                        self.deliveryDate?.append(deliverydate1)
                    }else{
                        self.deliveryDate1?.append(deliverydate1)
                    }
                    

                    
                   
                     
                }
                //                print(" the json numbwer is \(String(describing: self.items) )")
                
            case .failure(_):
                print("faliuress")
            }
            
        }
        
        
    }
}
