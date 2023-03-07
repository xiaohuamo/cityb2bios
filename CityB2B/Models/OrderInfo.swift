//
//  File.swift
//  CityB2B
//
//  Created by Fei Wang on 21/2/2023.
//

import Foundation
struct OrderInfo: Identifiable, Codable, Hashable {
    
    
    
    var id: Int
    var userId: String
    var business_userId: Int
    var orderId: String = ""
    var coupon_status: String = ""
    var paytime: Int = 0
    var createTime: Int = 0
    var money: String = "0.00"
    var money_new: String = "0.00"
    var xero_invoice_id: String = ""
    var quickbooks_invoice_id: String = ""
    var customer_delivery_option: String = "2"
    var logistic_delivery_date:  Int = 0
    var logistic_schedule_id:  Int = 0
    var logisitic_schedule_time: String = ""
    var logistic_arrived_time: String = ""
    var merge_to_another_order:  Int = 0
    var driver_receipt_status:  Int = 0
    var phone:  String = ""
    var order_end_time:  Int = 0
    var displayName: String = ""
    var displayName_en: String = ""
    var name: String = ""
    var operator_user_id:  Int = 0
    var operatorisDone_user_id:  Int = 0
    var allow_customer_cancel_order:  Int = 0
    var cancel_order_time_limit:  Int = 0
    var allow_customer_update_order:  Int = 0
    var update_order_time_limit: String = ""
    var xero_auto_pass:  Int = 0
    var quickbooks_auto_pass:  Int = 0
    var nickname: String = ""
    var invoice_id: String = ""
    var picking_status:  Int = 0
    var is_can_cancel_order:  Int = 0
    var is_can_update_order:  Int = 0
    var order_status: String = ""
    var delivery_option_value: String = ""
   
    var invoiceId :String = ""
}

