//
//  OrderDetails.swift
//  CityB2B
//
//  Created by Fei Wang on 23/2/2023.
//

import Foundation

struct OrderDetails: Codable {
    let orderInfo: OrderInfo1
    let itemsDetails: [ItemDetails]
    let moneyDetail: MoneyDetail
    let supplierInfo: SupplierInfo
    let log: [Log]
    
}


struct OrderInfo1: Codable {
    let id: Int
    let orderId: String
    let orderName: String
    let userId: Int
    let businessUserId: Int
    let money: String
    let moneyNew: String
    let payment: String
    let createTime: String
    let status: Int
    let couponStatus: String
    let logisticDeliveryDate: String
    let customerDeliveryOption: String
    let messageToBusiness: String
    let businessStaffId: String
    let deliveryFees: String
    let promotionTotal: String
    let couponTotal: String
    let firstName: String
    let lastName: String
    let phone: String
    let address: String
    let email: String
    let invoiceId: String
    let customerDeliveryOptionDesc: String
    let couponStatusDesc: String
    let couponStatusColor: String
    let payStatusDesc: String
    let payStatusColor: String
    let offlinePayDes: String
    let deliveryDescription: String
    let pickupDes: String
    let refundPolicy: String?
    let totalMoney: String
}


extension OrderInfo1 {
static var sampleOrderInfo1: OrderInfo1 {
return OrderInfo1(id: 1, orderId: "12345", orderName: "Sample Order", userId: 123, businessUserId: 456, money: "100.00", moneyNew: "90.00", payment: "Credit Card", createTime: "2022-02-23", status: 1, couponStatus: "Used", logisticDeliveryDate: "2022-03-01", customerDeliveryOption: "Delivery", messageToBusiness: "Please deliver to the front door.", businessStaffId: "789", deliveryFees: "5.00", promotionTotal: "10.00", couponTotal: "5.00", firstName: "John", lastName: "Doe", phone: "1234567890", address: "123 Main St", email: "john.doe@example.com", invoiceId: "67890", customerDeliveryOptionDesc: "Delivery", couponStatusDesc: "Coupon Used", couponStatusColor: "#00FF00", payStatusDesc: "Paid", payStatusColor: "#00FF00", offlinePayDes: "N/A", deliveryDescription: "Deliver to front door", pickupDes: "N/A", refundPolicy: "No refunds or exchanges", totalMoney: "95.00")
}
}




struct ItemDetails: Codable {
    let id: Int
    let orderId: String
    let productId: Int
    let guige1Id: Int
    let guigeDes: String
    let voucherDealAmount: String
    let menuPic100: String?
    let menuPic: String?
    let menuEnName: String
    let menuCnName: String
    let menuId: String
    let onSpecial: Int
    let qty: Int
    let limitBuyQty: Int
    let guigeName: String?
    let guigeNameCn: String?
    let unitEn: String
    let unit: String
    let customerBuyingQuantity: String
    let newCustomerBuyingQuantity: Int
    let returnQty: Int
    let reasonType: Int
    let note: String
    let title: String
    let subtitle: String
    let num: Int
    let delQuantity: Int
}


extension ItemDetails {
    var imageURL: URL {
        URL(string: menuPic ?? "https://www.marsfresh.com/data/upload/thumbnails/2020-04/20200428180801263266_100x100_fill.jpg")!
    }
    var image100URL: URL {
        URL(string: menuPic100 ?? "https://www.marsfresh.com/data/upload/thumbnails/2020-04/20200428180801263266_100x100_fill.jpg")!
    }
    static var sampleItemDetails: [ItemDetails] {
           return [
               ItemDetails(id: 126520, orderId: "20230213192851104408", productId: 385486, guige1Id: 0, guigeDes: "", voucherDealAmount: "25.00", menuPic100: "thumbnails/2020-04/20200428180801263266_100x100_fill.jpg", menuPic: "https://www.marsfresh.com/data/upload/thumbnails/2020-04/20200428180801263266_100x100_fill.jpg", menuEnName: "Breast Fillet Skinlessr", menuCnName: "无皮鸡胸肉", menuId: "C0001", onSpecial: 1, qty: 924206, limitBuyQty: 1, guigeName: nil, guigeNameCn: nil, unitEn: "kg", unit: "kg", customerBuyingQuantity: "1.00", newCustomerBuyingQuantity: 1, returnQty: 0, reasonType: 1, note: "", title: "Breast Fillet Skinlessr", subtitle: "", num: 1, delQuantity: 1),
               
               ItemDetails(id: 836523, orderId: "20230213193023385490", productId: 327589, guige1Id: 0, guigeDes: "", voucherDealAmount: "12.00", menuPic100: "thumbnails/2020-06/20200624182440836523_100x100_fill.jpg", menuPic: "https://www.marsfresh.com/data/upload/thumbnails/2020-06/20200624182440836523_100x100_fill.jpg", menuEnName: "Potato Chips", menuCnName: "薯片", menuId: "S0001", onSpecial: 0, qty: 56023, limitBuyQty: 2, guigeName: nil, guigeNameCn: nil, unitEn: "g", unit: "克", customerBuyingQuantity: "100.00", newCustomerBuyingQuantity: 2, returnQty: 0, reasonType: 1, note: "", title: "Potato Chips", subtitle: "", num: 1, delQuantity: 0)
           ]
       }
}

struct MoneyDetail: Codable {
    let transactionBalanceNew: String
    let deliveryFee: String
    let promotionTotal: String
    let couponTotal: String
    let goodsTotal: String
}

extension MoneyDetail {
    static var sampleMoneyDetail: MoneyDetail {
        return   MoneyDetail(transactionBalanceNew: "22.50", deliveryFee: "12.50", promotionTotal: "7.50", couponTotal: "20.50", goodsTotal: "78.50")
        
    }
    
}



struct SupplierInfo: Codable {
    let id: Int
    let userId: Int
    let businessName: String
    let ABNorACN: String
    let untityName: String
    let createDate: Int
    let isApproved: Int
    let auditUserId: Int
    let adultUserName: String
    let pics: String?
    let auditTime: Int
    let businessAddress: String
    let businessContactPhone: String
}

extension SupplierInfo {
    static var sampleSupplierInfo: SupplierInfo {
        return SupplierInfo(
            id: 123,
            userId: 456,
            businessName: "My Business",
            ABNorACN: "123456789",
            untityName: "My Business Pty Ltd",
            createDate: 1643356800, // 2022-01-28 00:00:00 +0000
            isApproved: 1,
            auditUserId: 789,
            adultUserName: "John Smith",
            pics: nil,
            auditTime: 1643529600, // 2022-01-30 00:00:00 +0000
            businessAddress: "123 Main St, Sydney NSW 2000",
            businessContactPhone: "02 1234 5678"
        )
    }
}

struct Log: Codable {
    let id: Int
    let orderId: String
    let bonusCodeId: String?
    let actionUserType: String?
    let actionUserId: String
    let actionUserName: String
    let toUserId: String?
    let toUserName: String?
    let genDate: String
    let actionId: String
    let changeAmount: String
    let changePoint: String
    let cnDescription: String?
    let en_description: String?
    let picture1: String?
    let isRead: Bool?
    let merge_to_order_id: String?
    let description: String?
   
}


extension Log {
    static var sampleLogs: [Log] {
        return [
            Log(id: 123, orderId: "ABC123", bonusCodeId: nil, actionUserType: nil, actionUserId: "456", actionUserName: "John Doe", toUserId: nil, toUserName: nil, genDate: "2022-01-01", actionId: "789", changeAmount: "10.00", changePoint: "100", cnDescription: "取消订",  en_description:"order cancel",
                 picture1: "",
                 isRead: true,
               merge_to_order_id:"0",
                description:"00"),
            Log(id: 234, orderId: "DEF456", bonusCodeId: nil, actionUserType: nil, actionUserId: "789", actionUserName: "Jane Doe", toUserId: nil, toUserName: nil, genDate: "2022-02-01", actionId: "012", changeAmount: "5.00", changePoint: "50", cnDescription: nil,  en_description:"order cancel",
                picture1: "",
                isRead: true,
              merge_to_order_id:"0",
               description:"00"),
            Log(id: 345, orderId: "GHI789", bonusCodeId: nil, actionUserType: nil, actionUserId: "012", actionUserName: "Bob Smith", toUserId: nil, toUserName: nil, genDate: "2022-03-01", actionId: "345", changeAmount: "20.00", changePoint: "200", cnDescription: nil,  en_description:"order cancel",
                picture1: "",
                isRead: true,
              merge_to_order_id:"0",
               description:"00")
        ]
    }
}



