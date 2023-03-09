//
//  ContentView2.swift
//  ShoppingApp
//
//
//

import SwiftUI
import PartialSheet


struct ContentView: View {
    //定义全局环境变量 user
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var shopCategoryVM: ShopCategoryViewModel
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    
    
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var mysupplierVM:SupplierViewModel
    @EnvironmentObject var languageViewModel: LanguageViewModel
    @EnvironmentObject var functionsVM: FunctionsViewModel
   
    
    
    @AppStorage("email") private var email:String = "";
    @AppStorage("password") private var password:String = "";
    @State private var selectedTabIndex = 0
       @State private var isOrdersViewActive = false
    var body: some View {
        //        这个页面使用了 navigagtionView 这样，并且使用了tabview的地步按钮对象
        
    
        NavigationView   {
            
            if user.userIsAuthenticated && !user.userIsAuthenticatedAndSynced {
                //                如果是登陆用户，则显示loading view
                LoadingView()
            }
            else if user.userIsAuthenticatedAndSynced {
                TabView(selection: $selectedTabIndex){
                 
                    SupplierView().tabItem {
                        Image(systemName: "house.fill")
                        Text("首页")
                    }.tag(0)
                  
                    CartView().tabItem {
                        Image(systemName: "cart.fill")
                        Text("购物车")
                    }.tag(1)
                    
                    OrdersView().tabItem {
                        Image(systemName: "doc.text.fill")
                        Text("订单")
                    }.tag(2)    
                    ProfileView(isOrdersViewActive: $isOrdersViewActive).tabItem {
                        Image(systemName: "person.fill")
                        Text("我的")
                    }.tag(3)
                   
                }.accentColor(.blue)
                
                ProfileView(isOrdersViewActive: .constant((0 != 0)))
            }
            else{
                AuthenticationView()
                
            }
        }
        .attachPartialSheetToRoot()
        .onChange(of: isOrdersViewActive) { isActive in
                    if isActive {
                        selectedTabIndex = 2
                    }
                }
        .onAppear{
            
            //            @AppStorage("email") private var email:String = "";
            //            @AppStorage("password") private var password:String = "";
           
            let language = user.setLanguage(user: user)
                        UserDefaults.standard.set([language], forKey: "AppleLanguages")
            
            let queue = DispatchQueue(label: "abc")
            
            queue.sync {
                user.signIn(email: email, password: password) { result in
                    switch result {
                    case .success:
                       break
                        
                    case .failure(let error):
                        user.alertTitle = "Errors"
                        user.alertMessage = error.localizedDescription ?? "Something went wrong"
                        user.showingAlert = true
                    }
                }
                
                if user.userIsAuthenticated{
                    user.sync()
                    
                }
                if (user.user_temp_tokens.isEmpty == false) {
                    homePageVM.getHomePageInfo(User_temp_tokens: user.user_temp_tokens)
                }
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

