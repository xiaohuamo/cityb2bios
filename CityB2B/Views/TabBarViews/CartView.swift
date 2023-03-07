//
//  CartView.swift
//  ShoppingApp
//
//  Created by kz on 17/11/2022.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    
    var body: some View {
        NavigationView {
            if self.cartVM.currentcart?.items?.count ?? 0 > 0 {
                 
                VStack{
                    Divider()
                    ScrollView{
                        
                        LazyVStack{
                            ForEach((self.cartVM.currentcart?.items)! , id: \.idd){ item in

                                ItemCartCell(item: item)

                               Divider()
                                   .overlay(Color.blue)
                               
                           }
                           
                       }
                      
                        
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("购物车")
                    Spacer()
                    VStack{
                        Divider()
                        HStack{
                            Text("总额:")
                                .padding([.leading])
                            
                            Spacer()
                            
                            
                            Text("$\(String(format: "%.2f", self.cartVM.cartTotalMoney ))")
                                .padding([.trailing])
                                .font(.system(size:18))
                                .bold()
                                .foregroundColor(Color("fontColorMain"))
                        }
                        NavigationLink(destination: PurchaseView() .environmentObject(user)){
                            HStack{
                                Image(systemName: "eye").bold().font(.body)
                                Text("购买").bold().font(.body)
                                
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
                
            }
            
            else{
                Text("购物车为空！")
                Spacer()
            }
                
        }

        .onAppear{
//            productVM.getUserCart()
            if(( homePageVM.currentFactoryAndUserId) != nil) {
                purchaseVM.getPurchaseInfo(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: user.user_temp_tokens, user_branch_id: "0")
     /*           purchaseVM.getPurchaseInfo(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: user.user_temp_tokens, user_branch_id: "0")
                
                deliveryDateVM.getDeliveryDate(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: user.user_temp_tokens, user_branch_id: "0")
          */
                cartVM.getCartItems(factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: user.user_temp_tokens, user_branch_id: "0")
                
            }
           
           
//            createOrderVM.getCreateOrderInitData(factory_id: <#T##String#>, user_id: <#T##String#>, user_branch_id: <#T##String#>, logistic_delivery_date: <#T##Int#>)
        }
       
        
    }
    
}


struct ProductCartCell: View{
    
    @State var product: Product
    @EnvironmentObject var productVM: ProductViewModel

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
                        Button {
                            productVM.removeProductFromCart(productID: product.id)
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding([.leading, .trailing])
                                .clipShape(Circle())
                        }
                        
                    }
 
                    HStack{
                        if product.isOnSale{
                            VStack{
                                Text("\(product.price)")
                                    .padding([.leading, .trailing])
                                    .font(.callout)
                                    .strikethrough()
                                    .foregroundColor(.gray).opacity(0.75)
                                    .frame(alignment: .trailing)
                                
                                Text("$\(product.onSalePrice)")
                                    .padding([.leading,.trailing])
                                    .foregroundColor(.red)
                                    .font(.callout)
                                    .font(.largeTitle)
                                    
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
                        
                        Spacer()
                        Text("数量: 1")
                            .foregroundColor(.black)
                            .font(.footnote)
                        .padding()
                                                
                    }
                    
                }
                
            }
            
        }

    }

}


struct ItemCartCell: View{
    
    @State var item: CartItem
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @State var quantity  = 0
    @FocusState var isQuantityFocused:Bool
    var body: some View{
        VStack(alignment: .leading){
            
            HStack{
                ProductSearchCellImage(imageURL: item.imageURL).padding(.leading, 2.0)
                VStack{
                    HStack{
                        Text(item.title ?? "no title")
                            .lineLimit(2)
                            .bold()
                            .font(.system(size: 16))
                            .foregroundColor(Color("fontColorMain"))
                            
                            
                     
                        Spacer()
                        Button {
                            cartVM.removeProductFromCart(itemId: item.idd,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens)
//                            cartVm.cu
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding(.horizontal, 4.0)
                                .clipShape(Circle())
                        }
                        
                    }.padding([.top, .leading, .bottom], 1.0)
                    HStack{
                        
                     
                            
                        Text(item.subtitle ?? "" )
                            .padding([.leading,.trailing], 1.0)
                            .foregroundColor(Color("fontColorMain"))
                     
                            .font(.system(size: 16))
                                .font(.largeTitle)
                                .frame(alignment: .leading)
                           
                      Spacer()
                       
                    }
                    .padding(.vertical, 1.0)
                   
                    HStack{
                        
                        Text((item.menu_id ?? "")  + " " + (item.unit ?? "") )
                            .padding([.leading,.trailing], 1.0)
                            .foregroundColor(Color("fontColorMain"))
                     
                            .font(.system(size: 16))
                                .font(.largeTitle)
                                .frame(alignment: .leading)
                           
                      Spacer()
                       
                    }
                    if(item.guige_ids?.codingKey.intValue ?? 0 > 0 ) {
                        
                         HStack{
                             
                             Text(item.guige_des ?? "" )
                                 .padding([.leading,.trailing], 1.0)
                                 .foregroundColor(Color("fontColorMain"))
                          
                                 .font(.system(size: 16))
                                     .font(.largeTitle)
                                     .frame(alignment: .leading)
                                
                           Spacer()
                            
                         }
                    }
                  
                    
                    HStack{
                        Text("$\(item.price ?? "0.00")"      )
                        .padding(.trailing, 8.0)
                            .foregroundColor(.red)
                            .font(.callout)
                            .font(.largeTitle)
                            
                     Spacer()
                       
                        Button {
                            quantity = quantity-1
                            if(quantity < 0) { quantity = 0 }
                            cartVM.updateCartItemQuantity(itemId: item.idd,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:quantity)
                          
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
                            .foregroundColor(Color("fontColorMain")) .focused($isQuantityFocused)
                            .keyboardType(.numberPad)
                            
                            
                        Button {
                          
                                quantity = quantity+1
                            cartVM.updateCartItemQuantity(itemId: item.idd,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:quantity)
                          
                            print("ready to add \(item.id)")
                        } label: {
                            HStack() {
                                   Image("jia")
                                    .bold().font(.callout)
                                   
                               }

                            .padding(1)
                            .foregroundColor(.white)
                          
                               
                        }
                    }

                }.padding(2.0)
                    .onChange(of:isQuantityFocused){ value in
                        cartVM.updateCartItemQuantity(itemId: item.idd,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:quantity)
                       print(" hi the value changed \(item.id )  \(quantity)  ")
                   }
                    
                    
                    
                    
                    
                
                
            }
            .padding(.horizontal, 5.0)
            
        }.onAppear{
           
            quantity = item.num ?? 0
        }
    }

    

}


struct CartView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ItemCartCell(item: CartItem.sampleCartItem)
            .environmentObject(CartViewModel())
    }
    
}
