//
//  Supplier.swift
//  CityB2B
//
//  Created by Fei Wang on 27/1/2023.
//

import Foundation

struct Supplier1:  Identifiable, Codable, Hashable {
    
    var id: String
    var supplierName : String
    var img: String
    var supplierUrl:String
    
}

extension Supplier1{
    var imageURL: URL {
        URL(string: img)!
    }

    static var sampleSuppliers: [Supplier1] {
        return [Supplier1(id: "319188", supplierName: "dnl trading pty ltd" , img: "http://marsfresh.com/data/upload/2022-08/20220801082029124095.png",supplierUrl:"aa"),
                Supplier1(id: "321484", supplierName: "nicegome" , img: "http://marsfresh.com/data/upload/2022-08/20220818070120130762.png",supplierUrl:"aa")]
    }
    
    static var sampleSupplier: Supplier1 {
        return Supplier1(id: "321484", supplierName: "nicegome" , img: "http://marsfresh.com/data/upload/2022-08/20220818070120130762.png",supplierUrl:"aa")
    }


}

