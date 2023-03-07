//
//  AppData.swift
//  lesson12
//
//  Created by Fei Wang on 27/1/2023.
//

import SwiftUI

struct Supplier: Codable, Identifiable {
    let id: Int
    let supplierName: String
    let img: String
    let supplierUrl: String
    
}

extension Supplier{
    var imageURL: URL {
        URL(string: img)!
    }
    
}

struct AppData: Codable {
    var list: [Supplier]
}

func loadJsonData() -> [Supplier] {
    let filename: String = "data1.json"
    guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Can not find \(filename) in main bundle")
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not load \(url)")
    }
    guard let appData = try? JSONDecoder().decode(AppData.self, from: data) else {
        fatalError("Can not parse post list json data")
    }
    return appData.list
}
