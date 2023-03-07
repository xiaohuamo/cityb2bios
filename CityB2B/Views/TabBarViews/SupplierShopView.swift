//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI
import PartialSheet


struct SupplierShopView: View {
    
    @State var searchText = ""
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var shopCategoryVM: ShopCategoryViewModel
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    var message : CurrentUserFactorys
    var body: some View {
        
        NavigationView{
            if self.itemVM.items != nil{
                if self.searchText != "" && !self.searchText.isEmpty {
                    ScrollView{
                        LazyVStack{
                            ForEach(self.itemVM.items!.filter{(self.searchText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(self.searchText))}, id: \.id){ item in
                                NavigationLink(destination: ItemDetailsView(item: item)) {
                                    ItemSearchCell(item: item)}
                                
                                Divider()
                                    .overlay(Color("diverLineColor"))
                                
                            }
                            
                        }
                        
                    }
                    
                }
                else {
                    ScrollViewReader { value in
                        HStack{
                            VStack(alignment: .leading){
                                List{
                                    Section(){
                                        if(self.shopCategoryVM.shopCategory != nil ) {
                                            ForEach(self.shopCategoryVM.shopCategory!, id: \.id) { item in
                                                
                                                
                                                Button(action: {
                                                    
                                                    
                                                    withAnimation {
                                                        value.scrollTo(findItemId(cateId: item.id), anchor: .top)
                                                    }
                                                    //                                                   print("scroll to \(item.id)")
                                                }, label: {
                                                    Text("\(item.title)").foregroundColor(Color("fontColorMain"))
                                                        .font(.system(size:12))
                                                }).background(Color("backgroundCat"))
                                                
                                            }.background(Color("backgroundCat"))
                                        }
                                        
                                        
                                    }
                                    
                                }
                                .listStyle(.grouped)
                                .scrollDisabled(true)
                                .scrollContentBackground(.hidden)
                                
                            }.frame(width: 80)
                                .padding(2)
                            
                            
                            VStack(alignment: .leading){
                                ScrollView{
                                    
                                    LazyVStack{
                                        
                                        
                                        if(self.itemVM.items != nil ) {
                                            
                                            ForEach(self.itemVM.items!, id: \.id){ item in
                                                
                                                ItemSearchCell(item: item)
                                                
                                                Divider()
                                                    .overlay(Color("diverLineColor"))
                                                
                                            }
                                            
                                        }
                                        
                                    }.padding(1)
                                    
                                }.padding(1)
                                
                            }.frame(width:.infinity)
                                .padding(2)
                            
                            
                        }.padding(1)
                    }.padding(1)
                    
                }
                
            }
            
        }
        
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("选购商品")
                    .font(.headline)
                    .foregroundColor(Color("fontColorMain"))
            }
            
        }
        .padding(2)
        .background(.gray.opacity(0.1))
        .searchable(text: $searchText)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        .onAppear{
            //            获得当前商家的配送日期信息
            self.homePageVM.currentFactoryAndUserId = message
            
            if(( homePageVM.currentFactoryAndUserId) != nil) {
                
                shopCategoryVM.getShopCategories(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens)
                
                deliveryDateVM.getDeliveryDate(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens, user_branch_id: "0")
                
                itemVM.getItems(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens)
            }
            
        }
        
    }
    
    func findItemId(cateId:String)-> Int{
        var itemId :Int = 0
        for element in self.itemVM.items! {
            if element.parent_category_id == cateId {
                itemId = element.id
                break
            }
            
        }
        
        
        
        return itemId
    }
    
}

struct ItemSearchByCategory: View{
    
    var parent_category_id: String
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @State var itemCounter: Int = 0
    
    var body: some View{
        NavigationView{
            if itemCounter > 0 {
                ScrollView{
                    LazyVStack{
                        VStack{
                            Text("发现 \(itemCounter) 产品")
                            Divider()
                                .overlay(Color("diverLineColor"))
                            if(self.itemVM.items != nil){
                                ForEach(self.itemVM.items!.filter{$0.parent_category_id!.contains(self.parent_category_id) }, id: \.id) { item in
                                    ItemSearchCell(item: item)
                                    Divider()
                                        .overlay(Color("diverLineColor"))
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            } else {
                Text("当前品类无产品！")
                Spacer()
            }
            
        }
        .onAppear{
            self.itemCounter = self.itemVM.items!.filter{$0.parent_category_id!.contains(self.parent_category_id) }.count
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(parent_category_id)
    }
    
}

struct ItemSearchCell: View{
    
    var item: Item
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var shopCategoryVM: ShopCategoryViewModel
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    @FocusState var isQuantityFocused:Bool
    @State var quantity  = 0
    @State var isGuigeSheetPresented :Bool = false
    
    var body: some View{
        HStack{
            
            NavigationLink(destination: ItemDetailsView(item: item)) {
                ItemSearchCellImage(imageURL: item.imageURL)}
            .padding(1)
            .frame(width: 120,height: 120,alignment: .center)
            VStack(alignment: .leading){
                
                NavigationLink(destination: ItemDetailsView(item: item)) {
                    Text(item.title)}
                
                
                
                
                .lineLimit(2)
                .bold()
                .font(.system(size: 16))
                .multilineTextAlignment(.leading)
                
                .foregroundColor(Color("fontColorMain"))
                Text(item.subtitle ?? "")
                    .font(.system(size: 16))
                    .bold()
                    .lineLimit(2)
                
                    .multilineTextAlignment(.leading)
                
                    .foregroundColor(Color("fontColorMain"))
                
                Text(item.menu_id + " " + item.unit)
                    .lineLimit(2)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                
                    .foregroundColor(Color("fontColorMain"))
                
                HStack{
                    if item.onSpecial == 1 {
                        VStack{
                            HStack {
                                Text("\(String(format: "%.2f", item.price ?? 0.00) )")
                                    .bold()
                                
                                    .font(.system(size: 18))
                                
                                    .foregroundColor(Color("priceFontColor"))
                                    .frame(alignment: .trailing)
                                
                                Text("\(String(format: "%.2f", item.old_price ?? 0.00) )")
                                    .padding([.leading,.trailing])
                                    .foregroundColor(.gray)
                                    .strikethrough()
                                    .font(.system(size: 14))
                            }
                        }
                        .frame(alignment: .center)
                    }
                    else {
                        Text("\(String(format: "%.2f", item.price ?? 0.00) )")
                            .multilineTextAlignment(.leading)
                        
                            .bold()
                            .foregroundColor(Color("priceFontColor"))
                        
                    }
                    Spacer()
                }
                
                if(item.hasGG == 1 ){
                    HStack{
                        Spacer()
                        
                        Button {
                             itemVM.getProductInfo(factoryAndUser: self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens, id: item.id)
                               
                            isGuigeSheetPresented = true
                        } label: {
                            Text("选规格")
                                .font(.system(size: 14))
                            .padding(4)
                            .foregroundColor(.white)
                            .background(Color("mainBlue"))
                            .cornerRadius(4)
                        }   .sheet(isPresented: $isGuigeSheetPresented){
                             itemDetailView(item:itemVM.productInfo ?? ProductInfo.sampleProductInfo
                            )
                        }
   
                        
                    }
                }else{
                    HStack{
                        Spacer()
                        
                        Button {
                            quantity = quantity-1
                            if(quantity < 0) { quantity = 0 }
                            cartVM.addItemToCart(itemId: item.id,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:quantity,guige_ids:0)
                            print("ready to add \(item.id)")
                        } label: {
                            HStack() {
                                Image( "jian")
                                    .bold().font(.callout)
                                
                            }
                            
                            .padding(1)
                            .foregroundColor(.white)
                            
                            
                            
                        }
                        
                        TextField("", value: $quantity, format: .number)
                            .textFieldStyle(.roundedBorder)
                        
                        
                            .frame(width: 55,height: 25)
                            .foregroundColor(Color("fontColorMain"))
                            
                            .keyboardType(.numberPad)
                        
                        Button {
                            
                            quantity = quantity+1
                            //                        input_quantity += 1
                            cartVM.addItemToCart(itemId: item.id,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:quantity,guige_ids:0)
                            print("ready to add \(item.id)")
                        } label: {
                            HStack() {
                                Image("jia")
                                    .bold().font(.callout)
                                
                            }
                            
                            .padding(1)
                            .foregroundColor(.white)
                            
                            
                        }   .onChange(of:isQuantityFocused){ value in
                            cartVM.addItemToCart(itemId: item.id,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:quantity,guige_ids:0)
                            print(" hi the value changed \(item.id )  \(quantity)  ")
                        }
                    }
                    
                }
                
            }.padding(2.0)
            
            
        }.onAppear{
            quantity = item.num ?? 0
        }
        //        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
        
    }
    
}

struct ItemSearchCellImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 120, height: 120, alignment: .center)
                .cornerRadius(4)
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
                                    .cornerRadius(4)
                                    .padding(1)
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(4)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
        
    }
    
}

struct SupplierShopView_Previews: PreviewProvider {
    static var previews: some View {
        ItemSearchCell(item: Item.sampleItem)
            .environmentObject(ItemViewModel())
    }
}
