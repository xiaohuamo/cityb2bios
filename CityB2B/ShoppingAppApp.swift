//
//  ShoppingAppApp.swift
//  ShoppingApp
//
//  Created by kz on 13/11/2022.
//

import SwiftUI
import Firebase

@main
struct CityB2BApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
    @StateObject  var language = LanguageViewModel()
    @StateObject  var user = UserViewModel()
    @StateObject  var product = ProductViewModel()
    @StateObject  var order = OrderViewModel()
    @StateObject  var shopcategory = ShopCategoryViewModel()
    @StateObject  var item = ItemViewModel()
    @StateObject  var cart = CartViewModel()
    @StateObject  var purchase = PurchaseViewModel()
    @StateObject  var deliverydatepanel = DeliveryDateViewModel()
    @StateObject  var createorder = CreateOrderViewModel()
    @StateObject  var homepage = HomePageViewModel()
    @StateObject  var mysuppliers = SupplierViewModel()
    @StateObject  var functions = FunctionsViewModel()
    
  
    
    var body: some Scene {
        WindowGroup {
           
          
            ContentView()
                .environmentObject(user)
                .environmentObject(product)
                .environmentObject(order)
                .environmentObject(shopcategory)
                .environmentObject(item)
                .environmentObject(cart)
                .environmentObject(purchase)
                .environmentObject(deliverydatepanel)
                .environmentObject(createorder)
                .environmentObject(homepage)
                .environmentObject(mysuppliers)
                .environmentObject(language)
                .environmentObject(functions)
            

        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
