//
//  MyBusiness.swift
//  CityB2B
//
//  Created by Fei Wang on 1/3/2023.
//

import Foundation
struct MySupplier: Identifiable, Decodable,Hashable {
    let id: Int
    let user_id: Int
    let logo: URL?
    let displayName: String
    let phone: String
    let googleMap: String
    let business_nick_name: String?
    let business_note: String?
    let pic: URL?
    let categoryId: [String: String]
    let remark_name: String
    let py: String
 
}



extension MySupplier {
    static var sampleMysuppliers: [MySupplier] {
        return [
            MySupplier(
                id: 1,
                user_id: 123,
                logo: URL(string: "https://example.com/logo.png")!,
                displayName: "ABC Corporation",
                phone: "123-456-7890",
                googleMap: "https://maps.google.com/maps?q=123+Main+St",
                business_nick_name: nil,
                business_note: nil,
                pic: URL(string: "https://example.com/pic.png")!,
                categoryId: ["1": "Computers", "2": "Accessories"],
                remark_name: "remark",
                py: "py"
            ),
            MySupplier(
                id: 2,
                user_id: 456,
                logo: URL(string: "https://example.com/logo2.png")!,
                displayName: "XYZ Inc.",
                phone: "987-654-3210",
                googleMap: "https://maps.google.com/maps?q=456+Oak+St",
                business_nick_name: "nick",
                business_note: "note",
                pic: URL(string: "https://example.com/pic2.png")!,
                categoryId: ["3": "Electronics"],
                remark_name: "remark2",
                py: "py2"
            )
        ]
    }
    
    static var sampleMySupplier: MySupplier {
        return MySupplier(
            id: 1,
            user_id: 123,
            logo: URL(string: "https://www.marsfresh.com/data/upload/2022-03/20220316131516206759.png)!"),
            displayName: "ABC Corporation",
            phone: "123-456-7890",
            googleMap: "https://maps.google.com/maps?q=123+Main+St",
            business_nick_name: nil,
            business_note: nil,
            pic: URL(string: "https://example.com/pic.png")!,
            categoryId: ["1": "Computers", "2": "Accessories"],
            remark_name: "remark",
            py: "py"
        )
    }
}
