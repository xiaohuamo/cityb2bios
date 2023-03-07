//
//  MainView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct SupplierView: View {
    //    声明两个全局变量
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var shopCategoryVM: ShopCategoryViewModel
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    
    
    
    let appData: AppData
    
    init() {
        self.appData = AppData(list: loadJsonData())
        
        
    }
    
    var body: some View {
        NavigationView{
            VStack{
                //                使用scrolview 做滚动效果，下面使用VStack 排版，并从推荐库中获得产品
                //                 并且使用 productcarousel进行强制转换和显示
                ScrollView(.vertical){
                    
                    
                    
                    
                    
                    VStack(alignment: .leading){
                        if(self.homePageVM.factorylistsOfCurrentUser.isEmpty == false) {
                            ForEach(self.homePageVM.factorylistsOfCurrentUser){ product in
                                VStack {
                                    Text(product.displayName)
                                        .font(.system(size:20))
                                        .multilineTextAlignment(.leading)
                                        .padding(.leading)
                                    NavigationLink(destination: SupplierShopView(message:product)) {
                                        
                                        
                                        SupplierBannerImage(imageURL: product.imageURL)
                                        
                                        
                                    }
                                    
                                }
                                .onTapGesture {
                                    self.homePageVM.currentFactoryAndUserId = product
                                    
                                }
                                
                            }
                        }
                        
                        
                        
                    }
                    
                    Spacer(minLength: 20)
                    
                    
                    
                }
                
            }
            .navigationBarTitle("CityB2B")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: LeadingBarItem(), trailing: TrailingBarItem())
        }
        
        .onAppear{
//            productVM.getPromotedProducts()
//            productVM.getOnSaleProducts()
//            productVM.getProducts()
            //            productVM.getUserWatchList()
            //            productVM.getUserCart()
            
            //            itemVM.getItems()
            
            
   /*         if(( homePageVM.currentFactoryAndUserId) != nil) {
                
                shopCategoryVM.getShopCategories(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens)
                
                cartVM.getCartItems(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens,user_branch_id: "0")
                
                
                
                purchaseVM.getPurchaseInfo(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens, user_branch_id: "0")
            } */
            if (userVM.user_temp_tokens.isEmpty == false) {
                homePageVM.getHomePageInfo(User_temp_tokens: userVM.user_temp_tokens)
            }
            
            
        }
        
        .alert(isPresented: $userVM.showingAlert){
            Alert(
                title: Text(userVM.alertTitle),
                message: Text(userVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
        .alert(isPresented: $createOrderVM.showingAlert){
            Alert(
                title: Text(createOrderVM.alertTitle),
                message: Text(createOrderVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
   
}

struct LeadingBarItem:View{
    
    var body: some View {
        
        Button(
            action: {},
            label: {
                HStack(alignment: .firstTextBaseline) {
                    Image( "blue")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                    
                    
                    
                }
            })
    }
}

struct   TrailingBarItem:  View{
    var body: some View {
        HStack(alignment: .center,spacing: 20) {
            Button(
                action: {},
                label: {
                    
                    Image(systemName:  "arrow.up.forward.circle")
                        .foregroundColor(.black)
                })
            
            Button(
                action: {},
                label: {
                    
                    Image(systemName:  "plus")
                        .foregroundColor(.black)
                    
                    
                })
        }
    }
}

struct SupplierBannerImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(height: 140,alignment: .center)
                .frame(maxWidth: .infinity)
                .cornerRadius(12)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}
struct SupplierView_Previews: PreviewProvider {
    static var previews: some View {
        SupplierView()
    }
}
