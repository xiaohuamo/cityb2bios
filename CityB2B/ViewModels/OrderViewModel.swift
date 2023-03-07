//
//  OrderViewModel.swift
//  ShoppingApp
//
//  Created by kz on 23/01/2023.
//

import Foundation

import SwiftUI
import SwiftyJSON
import Alamofire

class OrderViewModel: ObservableObject {
    
    
    
    
    @Published var orders: [Order]?
    @Published var orderList: [OrderInfo]?
    
    @Published var orderDetails: OrderDetails?
   
    @Published var supplier_id: String = ""
    @Published var supplier_name: String = ""
    @Published var searchStartDate: String = ""
    @Published var searchEndDate: String = ""
    
    //ALERTS
    @Published var showingAlert : Bool = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    func getUserOrders(factoryId : String,start_time : String, end_time: String, User_temp_tokens: String){
        
        self.orders = nil
        self.orderList = [OrderInfo]()
        var orderinfo :OrderInfo?
        let url = "https://m.marsfresh.com/api/orderList"
        let user_temp_tokens: String = User_temp_tokens
        
        
        let params = ["factory_id":factoryId,"start_time":start_time,"end_time":end_time]
        let headers: HTTPHeaders = [
            "token": User_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value1):
                let json = JSON(value1)
                let  value2 = json["result"]
                let value3 = value2["data"]
                
                
                
                print("\(value3)")
                
                
                for (key, value) in value3 {
                    
                    let id = value["id"].intValue
                    let userId = value["userId"].stringValue
                    let business_userId = value["business_userId"].intValue
                    let orderId = value["orderId"].stringValue
                    let coupon_status = value["coupon_status"].stringValue
                    
                    
                    
                    
                    let paytime = value["paytime"].intValue
                    let createTime = value["createTime"].intValue
                    
                    let money = value["money"].stringValue
                    let money_new = value["money_new"].stringValue
                    
                    
                    let xero_invoice_id = value["xero_invoice_id"].stringValue
                    let quickbooks_invoice_id = value["quickbooks_invoice_id"].stringValue
                    let customer_delivery_option = value["customer_delivery_option"].stringValue
                    
                    
                    
                    
                    let logistic_delivery_date = value["logistic_delivery_date"].intValue
                    let logistic_schedule_id = value["logistic_schedule_id"].intValue
                    
                    let logisitic_schedule_time = value["logisitic_schedule_time"].stringValue
                    let logistic_arrived_time = value["logistic_arrived_time"].stringValue
                    
                    
                    
                    let merge_to_another_order = value["merge_to_another_order"].intValue
                    let driver_receipt_status = value["driver_receipt_status"].intValue
                    
                    
                    
                    let phone = value["phone"].stringValue
                    let order_end_time = value["order_end_time"].intValue
                    
                    
                    let displayName = value["displayName"].stringValue
                    let displayName_en = value["displayName_en"].stringValue
                    
                    
                    let name = value["name"].stringValue
                    
                    
                    let operator_user_id = value["operator_user_id"].intValue
                    let operatorisDone_user_id = value["operatorisDone_user_id"].intValue
                    let allow_customer_cancel_order = value["allow_customer_cancel_order"].intValue
                    let cancel_order_time_limit = value["cancel_order_time_limit"].intValue
                    let allow_customer_update_order = value["allow_customer_update_order"].intValue
                    
                    
                    
                    let update_order_time_limit = value["update_order_time_limit"].stringValue
                    
                    let xero_auto_pass = value["xero_auto_pass"].intValue
                    let quickbooks_auto_pass = value["quickbooks_auto_pass"].intValue
                    
                    let nickname = value["nickname"].stringValue
                    let invoice_id = value["invoice_id"].stringValue
                    
                    let picking_status = value["picking_status"].intValue
                    let is_can_cancel_order = value["is_can_cancel_order"].intValue
                    let is_can_update_order = value["is_can_update_order"].intValue
                    let order_status = value["order_status"].stringValue
                    
                    let delivery_option_value = value["delivery_option_value"].stringValue
                    
                    var invoiceId:String?
                    if(xero_invoice_id != nil && xero_invoice_id.isEmpty == false && xero_auto_pass == 1){
                        invoiceId = xero_invoice_id
                    }else if (quickbooks_invoice_id != nil && quickbooks_invoice_id.isEmpty == false && quickbooks_auto_pass == 1){
                        invoiceId = quickbooks_invoice_id
                    }else{
                        invoiceId = invoice_id
                    }
                    
                    
                    orderinfo = OrderInfo(id: id,userId:userId,business_userId: business_userId,orderId:orderId,coupon_status:coupon_status,paytime:paytime, createTime:createTime,money:money,money_new:money_new,xero_invoice_id:xero_invoice_id,quickbooks_invoice_id:quickbooks_invoice_id,customer_delivery_option:customer_delivery_option,logistic_delivery_date:logistic_delivery_date,logistic_schedule_id:logistic_schedule_id,logisitic_schedule_time:logisitic_schedule_time,logistic_arrived_time:logistic_arrived_time,merge_to_another_order:merge_to_another_order,driver_receipt_status:driver_receipt_status,phone:phone,order_end_time:order_end_time,displayName:displayName,displayName_en:displayName_en,name:name,operator_user_id:operator_user_id,operatorisDone_user_id:operatorisDone_user_id,allow_customer_cancel_order:allow_customer_cancel_order,cancel_order_time_limit:cancel_order_time_limit,allow_customer_update_order:allow_customer_update_order,update_order_time_limit:update_order_time_limit,xero_auto_pass:xero_auto_pass,quickbooks_auto_pass:quickbooks_auto_pass,nickname:nickname,invoice_id:invoice_id,picking_status:picking_status,is_can_cancel_order:is_can_cancel_order,is_can_update_order:is_can_update_order,order_status:order_status,delivery_option_value:delivery_option_value,invoiceId:invoiceId ?? "-"
                    )
                    if(orderinfo != nil) {
                        self.orderList?.append(orderinfo!)
                    }
                    
                    print(self.orderList as Any)
                    
                    
                    
                }
                
                
                
                
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
            
        }
        
    }
    
    func getOrderInfo(value :JSON )->OrderInfo1{
       
        
        let id = value["id"].intValue
        let orderId = value["orderId"].stringValue
        let orderName = value["order_name"].stringValue
        let userId = value["userId"].intValue
        let businessUserId = value["business_userId"].intValue
        let money = value["money"].stringValue
        let moneyNew = value["money_new"].stringValue
        let payment = value["payment"].stringValue
        let createTime  = value["createTime"].stringValue
        let status = value["status"].intValue
        let couponStatus = value["coupon_status"].stringValue
        let logisticDeliveryDate = value["logistic_delivery_date"].stringValue
        let customerDeliveryOption = value["customer_delivery_option"].stringValue
        let messageToBusiness = value["message_to_business"].stringValue
        let businessStaffId = value["business_staff_id"].stringValue
        let deliveryFees = value["delivery_fees"].stringValue
        let promotionTotal = value["promotion_total"].stringValue
        let couponTotal = value["coupon_total"].stringValue
        let firstName = value["first_name"].stringValue
        let lastName = value["last_name"].stringValue
        let phone = value["phone"].stringValue
        let address = value["address"].stringValue
        let email = value["email"].stringValue
        let invoiceId = value["invoiceId"].stringValue
        let customerDeliveryOptionDesc = value["customer_delivery_option_desc"].stringValue
        let couponStatusDesc = value["coupon_status_desc"].stringValue
        let couponStatusColor = value["coupon_status_color"].stringValue
        let payStatusDesc = value["pay_status_desc"].stringValue
        let payStatusColor = value["pay_status_color"].stringValue
        let offlinePayDes = value["offline_pay_des"].stringValue
        let deliveryDescription = value["delivery_description"].stringValue
        let pickupDes = value["pickup_des"].stringValue
        let refundPolicy = value["refund_policy"].stringValue ?? ""
        let totalMoney = value["total_money"].stringValue
        
        
       
        
        return OrderInfo1(id: id,
                          orderId: orderId,
                          orderName: orderName,
                          userId: userId,
                          businessUserId: businessUserId,
                          money: money,
                          moneyNew: moneyNew,
                          payment: payment,
                          createTime: createTime,
                          status: status,
                          couponStatus: couponStatus,
                          logisticDeliveryDate: logisticDeliveryDate,
                          customerDeliveryOption: customerDeliveryOption,
                          messageToBusiness: messageToBusiness,
                          businessStaffId: businessStaffId,
                          deliveryFees: deliveryFees,
                          promotionTotal: promotionTotal,
                          couponTotal: couponTotal,
                          firstName: firstName,
                          lastName: lastName,
                          phone: phone,
                          address: address,
                          email: email,
                          invoiceId: invoiceId,
                          customerDeliveryOptionDesc: customerDeliveryOptionDesc,
                          couponStatusDesc: couponStatusDesc,
                          couponStatusColor: couponStatusColor,
                          payStatusDesc: payStatusDesc,
                          payStatusColor: payStatusColor,
                          offlinePayDes: offlinePayDes,
                          deliveryDescription: deliveryDescription,
                          pickupDes: pickupDes,
                          refundPolicy: refundPolicy,
                          totalMoney: totalMoney)

    }
    
    func getMoneyDetail(value: JSON) -> MoneyDetail {
        let transactionBalanceNew = value["transactionBalanceNew"].stringValue
        let deliveryFee = value["deliveryFee"].stringValue
        let promotionTotal = value["promotionTotal"].stringValue
        let couponTotal = value["couponTotal"].stringValue
        let goodsTotal = value["goodsTotal"].stringValue
        
        return MoneyDetail(transactionBalanceNew: transactionBalanceNew,
                           deliveryFee: deliveryFee,
                           promotionTotal: promotionTotal,
                           couponTotal: couponTotal,
                           goodsTotal: goodsTotal)
    }

    
    
    func getItemsDetails( value1 :JSON ) -> [ItemDetails] {
        
        var itemSDetails :ItemDetails?
        
        var itemDetailsarr = [ItemDetails]()
        
        for (_, value) in value1 {
            
            let id = value["id"].intValue
            let orderId = value["order_id"].stringValue
            let productId = value["product_id"].intValue
            let guige1Id = value["guige1_id"].intValue
            let guigeDes = value["guige_des"].stringValue
            let voucherDealAmount = value["voucher_deal_amount"].stringValue
            let menuPic100 = value["menu_pic_100"].stringValue
            let menuPic = value["menu_pic"].stringValue
            let menuEnName = value["menu_en_name"].stringValue
            let menuCnName = value["menu_cn_name"].stringValue
            let menuId = value["menu_id"].stringValue
            let onSpecial = value["onSpecial"].intValue
            let qty = value["qty"].intValue
            let limitBuyQty = value["limit_buy_qty"].intValue
            let guigeName = value["guige_name"].stringValue
            let guigeNameCn = value["guige_name_cn"].stringValue
            let unitEn = value["unit_en"].stringValue
            let unit = value["unit"].stringValue
            let customerBuyingQuantity = value["customer_buying_quantity"].stringValue
            let newCustomerBuyingQuantity = value["new_customer_buying_quantity"].intValue
            let returnQty = value["return_qty"].intValue
            let reasonType = value["reasonType"].intValue
            let note = value["note"].stringValue
            let title = value["title"].stringValue
            let subtitle = value["subtitle"].stringValue
            let num = value["num"].intValue
            let delQuantity = value["del_quantity"].intValue
            
            
            itemSDetails = ItemDetails(id: id,
                                       orderId: orderId,
                                       productId: productId,
                                       guige1Id: guige1Id,
                                       guigeDes: guigeDes,
                                       voucherDealAmount: voucherDealAmount,
                                       menuPic100: menuPic100,
                                       menuPic: menuPic,
                                       menuEnName: menuEnName,
                                       menuCnName: menuCnName,
                                       menuId: menuId,
                                       onSpecial: onSpecial,
                                       qty: qty,
                                       limitBuyQty: limitBuyQty,
                                       guigeName: guigeName,
                                       guigeNameCn: guigeNameCn,
                                       unitEn: unitEn,
                                       unit: unit,
                                       customerBuyingQuantity: customerBuyingQuantity,
                                       newCustomerBuyingQuantity: newCustomerBuyingQuantity,
                                       returnQty: returnQty,
                                       reasonType: reasonType,
                                       note: note,
                                       title: title,
                                       subtitle: subtitle,
                                       num: num,
                                       delQuantity: delQuantity)
           
            if(itemSDetails != nil ) {
                itemDetailsarr.append(itemSDetails!)
            }
           
           
        }
        return itemDetailsarr
    }
    
    func getSupplierInfo(value: JSON) -> SupplierInfo {
        let id = value["id"].intValue
        let userId = value["userId"].intValue
        let businessName = value["businessName"].stringValue
        let ABNorACN = value["ABNorACN"].stringValue
        let untityName = value["untity_name"].stringValue
        let createDate = value["createDate"].intValue
        let isApproved = value["isApproved"].intValue
        let auditUserId = value["auditUserId"].intValue
        let adultUserName = value["adultUserName"].stringValue
        let pics = value["pics"].stringValue
        let auditTime = value["auditTime"].intValue
        let businessAddress = value["businessAddress"].stringValue
        let businessContactPhone = value["businessContactPhone"].stringValue
        
        return SupplierInfo(id: id,
                             userId: userId,
                             businessName: businessName,
                             ABNorACN: ABNorACN,
                             untityName: untityName,
                             createDate: createDate,
                             isApproved: isApproved,
                             auditUserId: auditUserId,
                             adultUserName: adultUserName,
                             pics: pics,
                             auditTime: auditTime,
                             businessAddress: businessAddress,
                             businessContactPhone: businessContactPhone)
    }
    
    
    func getLogs(value: JSON) -> [Log] {
        var logs: [Log] = []
        
        for (_, json) in value {
            let id = json["id"].intValue
            let orderId = json["orderId"].stringValue
            let bonusCodeId = json["bonus_code_id"].stringValue
            let actionUserType = json["action_user_type"].stringValue
            let actionUserId = json["action_user_id"].stringValue
            let actionUserName = json["action_user_name"].stringValue
            let toUserId = json["to_userId"].stringValue
            let toUserName = json["to_userName"].stringValue
            let genDate = json["gen_date"].stringValue
            let actionId = json["action_id"].stringValue
            let changeAmount = json["change_amount"].stringValue
            let changePoint = json["change_point"].stringValue
            let cnDescription = json["cn_description"].stringValue
            
            let en_description = json["en_description"].stringValue
            let picture1 = json["picture1"].stringValue
            let isRead = json["isRead"].boolValue
            let merge_to_order_id = json["merge_to_order_id"].stringValue
            let description = json["description"].stringValue
            
           
            
            let log = Log(id: id, orderId: orderId, bonusCodeId: bonusCodeId, actionUserType: actionUserType, actionUserId: actionUserId, actionUserName: actionUserName, toUserId: toUserId, toUserName: toUserName, genDate: genDate, actionId: actionId, changeAmount: changeAmount, changePoint: changePoint, cnDescription: cnDescription,en_description:en_description,picture1:picture1,isRead:isRead,merge_to_order_id:merge_to_order_id,description:description)
            
            logs.append(log)
        }
        
        return logs
    }

    

    
    func getOrderDetails(orderId : String, User_temp_tokens: String){
        
//        self.orderDetails = nil
      
       
        let url = "https://m.marsfresh.com/api/orderDetail"
        let user_temp_tokens: String = User_temp_tokens
        
        
        let params = ["orderId":orderId]
        let headers: HTTPHeaders = [
            "token": User_temp_tokens
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: URLEncoding.default, headers: headers).responseData {  response in
            debugPrint(response)
            switch response.result {
                
                
            case .success(let value1):
                let json = JSON(value1)
                let  value = json["result"]
                 let orderInfo1   = self.getOrderInfo(value:value["order"])
                    let itemsDetails1   = self.getItemsDetails(value1:value["items"])
                    let moneyDetail   = self.getMoneyDetail(value:value["moneyDetail"])
                    let supplierInfo   = self.getSupplierInfo(value: value["supplier_info"])
                    let log   = self.getLogs(value: value["log"])
                    
                     
                    self.orderDetails = OrderDetails(
                        orderInfo: orderInfo1, itemsDetails: itemsDetails1, moneyDetail: moneyDetail, supplierInfo: supplierInfo, log: log
                    )
                 
            case let .failure(error):
                self.alertTitle = "Errors"
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            }
            
        }
        
    }
    
}
