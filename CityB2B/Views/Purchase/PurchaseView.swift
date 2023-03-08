//
//  PurchaseView.swift
//  ShoppingApp
//
//  Created by kz on 23/01/2023.
//

import SwiftUI
import PartialSheet

struct PurchaseView: View {
    
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
  
    @Environment(\.dismiss) var dismiss
    //personal data
    @State private var firstname =  ""
    @State private var lastname = ""
    @State private var displayName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var address = ""
    
    
    //residence details
    @State private var city = ""
    @State private var street = ""
    @State private var streetNumber = ""
    @State private var houseNumber = ""
    
    @State private var isSheetPresented = false
    
    
    
    @State private var isAddressListSheetPresented = false
    
    @State private var isDeliveryOptionSheetPresented = false
    @State  private var currentDeliveryOptionValue :String  = ""
    
    @State private var isPaymentOptionSheetPresented = false
    @State  private var currentPaymentOptionValue :String  = ""
    
    @State private var isCurrentDeliveryDateSheetPresented = false
    @State  private var currentDeliveryDateValue :String  = ""
      
   
    var body: some View {
        
        NavigationLink(destination: OrderSuccessView(), isActive: $createOrderVM.orderSuccessful) { EmptyView() }.navigationTitle("订货成功")
        

           
        NavigationView {
            
            if purchaseVM.purchaseInfo?.items.items_count ?? 0 > 0 {
                VStack{
                    Form {
                        
                        Section(header: Text("选择配送日期")){
                            HStack{
                                Text("\(self.createOrderVM.createOrder?.logistic_delivery_date_desc ?? "")")
                                Spacer()
                                Button(action: {
                                    isCurrentDeliveryDateSheetPresented = true
                                }, label: {
                                    HStack() {
                                        Text("修改")
                                            .bold().font(.footnote)
                                    }
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .background(Color("mainBlue"))
                                    .cornerRadius(45)
                                })
                            }
                            .partialSheet(isPresented: $isCurrentDeliveryDateSheetPresented,
                                          content: DeliveryDateView.init)
                            .navigationBarTitle("Delivery Option")
                            .navigationViewStyle(StackNavigationViewStyle())
                            
                            
                            
                        }
                        .listRowInsets(EdgeInsets())
                        
                        
                        
                        
                        Section(header: Text("收获地址")){
                            VStack(alignment: .leading, spacing: 5){
                                HStack{
                                    Text(displayName )
                                    Spacer()
                                    Text(phone )
                                }
                                
                                HStack{
                                    Text((firstname + " " + lastname + " " + email).trimmingCharacters(in: .whitespacesAndNewlines))
                                   
                                 
                                    Spacer()
                                }
                                HStack{
                                    Text(address)
                                    Spacer(minLength: 10)
                                    Button(action: {
                                        isAddressListSheetPresented = true
                                    }, label: {
                                        HStack() {
                                               Text("修改")
                                                .bold().font(.footnote)
                                           }
                                       .padding(8)
                                        .foregroundColor(.white)
                                        .background(Color("mainBlue"))
                                        .cornerRadius(45)
                                    })
                                }
                           
                               
                           
                                
                            }.font(.system(size: 14))
                            /*
                            TextField("客户名", text: $displayName)
                                .textFieldStyle(.roundedBorder)
                               .listRowInsets(EdgeInsets())
                           TextField("收货人姓", text: $lastname)
                               .textFieldStyle(.roundedBorder)
                               .listRowInsets(EdgeInsets())
                           TextField("收货人名", text: $firstname)
                               .textFieldStyle(.roundedBorder)
                               .listRowInsets(EdgeInsets())
                           TextField("电话", text: $phone)
                               .textFieldStyle(.roundedBorder)
                               .listRowInsets(EdgeInsets())
                           TextField("Email", text: $email)
                               .textFieldStyle(.roundedBorder)
                               .listRowInsets(EdgeInsets())
                            TextField("地址", text: $address)
                                .textFieldStyle(.roundedBorder)
                                .listRowInsets(EdgeInsets())
                            */
                        }
                        .listRowInsets(EdgeInsets())
                        
                      
                        
                        
                        Section(header: Text("选择支付方式")){
                            HStack{
                                Text("\(self.currentPaymentOptionValue )")
                                Spacer()
                                Button(action: {
                                    isPaymentOptionSheetPresented = true
                                }, label: {
                                    HStack() {
                                           Text("修改")
                                            .bold().font(.footnote)
                                       }
                                   .padding(8)
                                    .foregroundColor(.white)
                                    .background(Color("mainBlue"))
                                    .cornerRadius(45)
                                })
                            }
                            .partialSheet(isPresented: $isPaymentOptionSheetPresented,
                                          content: PaymentOptionView.init)
                            .navigationBarTitle("Delivery Option")
                            .navigationViewStyle(StackNavigationViewStyle())
                            
                            
                            
                        }
                        .listRowInsets(EdgeInsets())
                        
                        
                        Section(header: Text("选择物流方式")){
                            HStack{
                                Text("\(self.purchaseVM.currentDeliverOptionValue ?? "")")
                                Spacer()
                                Button(action: {
                                    isDeliveryOptionSheetPresented = true
                                }, label: {
                                    HStack() {
                                           Text("修改")
                                            .bold().font(.footnote)
                                       }
                                   .padding(8)
                                    .foregroundColor(.white)
                                    .background(Color("mainBlue"))
                                    .cornerRadius(45)
                                })
                            }
                            .partialSheet(isPresented: $isDeliveryOptionSheetPresented,
                                          content: DeliveryOPtionView.init)
                            .navigationBarTitle("提交订单页")
                            .navigationViewStyle(StackNavigationViewStyle())
                            
                            HStack{
                               
                                Text("\(self.purchaseVM.currentDeliverOptionDesc ?? "")")
                            }.font(.system(size: 14))
                            
                        }
                        .listRowInsets(EdgeInsets())
                        
                        
                      
                      
                        
                        Section(header: Text("留言")){
                            TextField("留言", text: $city)
                                .textFieldStyle(.roundedBorder)
                                .listRowInsets(EdgeInsets())
                           
                            
                            
                        }
                        .listRowInsets(EdgeInsets())
                        
                    }
                    .foregroundColor(.black)
                    .scrollContentBackground(.hidden)
                    .listRowInsets(EdgeInsets())
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("购买")
                    Spacer()
                    
                    Button {
                        if( self.createOrderVM.createOrder != nil ) {
                            self.createOrderVM.submitOrder(AuthUser: self.user,CreateOrderInfo : self.createOrderVM.createOrder!)
                        } else {
                            purchaseVM.alertTitle = "Error"
                            purchaseVM.alertMessage = "所有信息都需要填写！"
                            purchaseVM.showingAlert = true
                        }
                    } label: {
                        HStack{
                            Image(systemName: "eye").bold().font(.body)
                            Text("下单").bold().font(.body)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(45)
                    }
                    .padding([.leading, .trailing, .bottom])
                 }
            }
            
            else{
                Text("购物车无产品！")
                Spacer()
            }
            
        }
        .alert(isPresented: $purchaseVM.showingAlert){
            Alert(
                title: Text(purchaseVM.alertTitle),
                message: Text(purchaseVM.alertMessage),
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
        
       
       
        .alert(isPresented: $createOrderVM.showingConfirm) {
                   Alert(title: Text("Title"), message: Text("message"),
                         primaryButton: .default(
                             Text("合并"),
                             action: {
                                 print("Try Again")
                                 self.createOrderVM.createOrder?.is_combine_order = 1
                                 self.createOrderVM.submitOrder(AuthUser: self.user,CreateOrderInfo: self.createOrderVM.createOrder!)
                             }
                         ),
                         secondaryButton: .destructive(
                             Text("不合并"),
                             action: {
                                 self.createOrderVM.createOrder?.is_combine_order = 2
                                 self.createOrderVM.submitOrder(AuthUser: self.user,CreateOrderInfo: self.createOrderVM.createOrder!)
                                 print("Delete")
                             }
                         ))
               }
        
        
        .onAppear{
           
            if(( homePageVM.currentFactoryAndUserId) != nil) {
                
                purchaseVM.getPurchaseInfo(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: user.user_temp_tokens, user_branch_id: "0")
            }
            
           
            self.init_date()
            
            let current_logistic_delivery_date :Int = self.deliveryDateVM.getCurrentSelectedDeliveryDate()
            
            //            设置配送日期
            
            if(homePageVM.factorylistsOfCurrentUser.isEmpty == false) {
                self.createOrderVM.getCreateOrderInitData(factoryAndUser:self.homePageVM.currentFactoryAndUserId!, user_branch_id: "0",logistic_delivery_date: current_logistic_delivery_date )
            }
//            如果初始化的下单信息不为空,并且当前的订单初始化里面没有值 ，则获得默认的配送设置（自取或配送），并对createorder 初始化
            if( self.purchaseVM.purchaseInfo != nil && self.createOrderVM.createOrder?.delivery_option == 0 ) {
                let default_delivery_option : Delivery_way = self.purchaseVM.getDefaultDelieryOptionValue()
//                print("defualt delivery option is \(default_delivery_option)")
                self.createOrderVM.setDeliveryOption(DeliveryOPtion: default_delivery_option.delivery_option ?? 1)
                self.purchaseVM.currentDeliverOption = default_delivery_option.delivery_option
                self.purchaseVM.currentDeliverOptionValue = default_delivery_option.delivery_option_value
                self.purchaseVM.currentDeliverOptionDesc = default_delivery_option.delivery_desc
//                print("defualt delivery option is \( )")
            }
//           设置 购物车明细信息
            if(self.purchaseVM.purchaseInfo?.items.items != nil) {
                self.createOrderVM.setItemsInfo(OrderItems: (self.purchaseVM.purchaseInfo?.items.items)!)
            }
           
            self.createOrderVM.createOrder?.address_id = self.purchaseVM.purchaseInfo?.default_address.id
            
//            self.createOrderVM.createOrder?.payment = "offline"
            let item_total_money  = Double((self.purchaseVM.purchaseInfo?.items_money)!)
            self.createOrderVM.createOrder?.total_money =  item_total_money ?? 0.00
            
            for i in 0 ..< self.purchaseVM.purchaseInfo!.pay_way.count {
                 
                if(self.purchaseVM.purchaseInfo?.delivery_way[i].is_default == 1) {
                    currentDeliveryOptionValue = self.purchaseVM.purchaseInfo?.delivery_way[i].delivery_option_value ?? ""
                    
                    print("Continent \(i+1):", self.purchaseVM.purchaseInfo!.delivery_way[i])
                }
                
                
            }
            
            
            for i in 0 ..< self.purchaseVM.purchaseInfo!.pay_way.count {
                
                if(self.purchaseVM.purchaseInfo?.pay_way[i].is_default == 1) {
                    self.createOrderVM.createOrder?.payment = self.purchaseVM.purchaseInfo?.pay_way[i].payment!
                    
                    print("default payment is  \(i+1):", self.purchaseVM.purchaseInfo!.pay_way[i])
                }
            }
            
            
         
        }
        
    }
    

    
    func init_date(){
        firstname = self.purchaseVM.purchaseInfo?.default_address.first_name ?? ""
        lastname = self.purchaseVM.purchaseInfo?.default_address.last_name ?? ""
        
        displayName = self.purchaseVM.purchaseInfo?.default_address.displayName ?? ""
        phone = self.purchaseVM.purchaseInfo?.default_address.phone ?? ""
        email = self.purchaseVM.purchaseInfo?.default_address.email ?? ""
        address = self.purchaseVM.purchaseInfo?.default_address.address ?? ""
        
        
        
        for i in 0 ..< self.purchaseVM.purchaseInfo!.delivery_way.count {
             
            if(self.purchaseVM.purchaseInfo?.delivery_way[i].is_default == 1) {
                currentDeliveryOptionValue = self.purchaseVM.purchaseInfo?.delivery_way[i].delivery_option_value ?? ""
                
                print("Continent \(i+1):", self.purchaseVM.purchaseInfo!.delivery_way[i])
            }
            
            
        }
    /*
        for i in 0 ..< self.purchaseVM.purchaseInfo!.pay_way.count {
             
            if(self.purchaseVM.purchaseInfo?.pay_way[i].is_default == 1) {
                currentPaymentOptionValue = self.purchaseVM.purchaseInfo?.pay_way[i].payment_option_value ?? ""
                
                print("Continent \(i+1):", self.purchaseVM.purchaseInfo!.pay_way[i])
            }
            
            
        }
     */
       
//        init create order data
        
       
        
        
    }
    
    
}

struct PurchaseCartLoader: View{
    
    @State var productID: String
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
//        在ScrollView 里面的部分是可以滚动的。
//        默认为垂直滚动， ScrollView(.horizontal) 为水平滚动。
        ScrollView{
//            LazyVStack是一个视图，可以将其子级排列在垂直增长的线中。LazyVStack特点是仅在需要时创建。
            LazyVStack{
                if self.productVM.products != nil{
                    ForEach(self.productVM.products!.filter{$0.id.contains(self.productID)}, id: \.id){ product in
                        PurchaseCartCell(product: product)
                            
                        Divider()
                            .overlay(Color.blue)
                    }
                    
                }

            }
            
        }
        
    }
    
}


struct PurchaseCartCell: View{
    
    @State var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    @State var quantity = 0

    var body: some View{
        VStack(alignment: .leading){
            
            HStack{
                ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
                VStack{
                    HStack{
                        Text(product.name)
                            .lineLimit(2)
                            .font(.callout)
                            .foregroundColor(.black)
                        Spacer()
                        
                        HStack{
                            if product.isOnSale{
                                VStack{
                                    Text("\(product.price)")
                                        .bold()
                                        .padding([.leading, .trailing])
                                        .font(.callout)
                                        .strikethrough()
                                        .foregroundColor(.black).opacity(0.75)
                                        .frame(alignment: .trailing)
                                    
                                    Text("$\(product.onSalePrice)")
                                        .padding([.leading,.trailing])
                                        .foregroundColor(.black)
                                        .font(.callout)
                                }
                                .frame(alignment: .center)
                            }
                            else {
                                Text("$\(product.price)")
                                    .bold()
                                    .font(.callout)
                                    .foregroundColor(.black)
                                    .padding()
                            }
       
                        }

                    }
                     
                }
                
            }
            
        }

    }

}



struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
