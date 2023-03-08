//
//  OrderSearchCell.swift
//  CityB2B
//
//  Created by Fei Wang on 24/2/2023.
//
import SwiftUI
import Foundation

struct OrderSearchCell: View{
    
    var order: OrderInfo
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var userVM: UserViewModel
   
    @State var isShoworderDetails :Bool = false
    
    var body: some View{
        
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: .infinity,height: 170)
            
            //
            
            NavigationLink(destination:ProfileView(isOrdersViewActive: .constant(false))){
                VStack(alignment: .leading){
                    HStack{
                        Text(order.invoiceId)
                            .foregroundColor(.black)
                        
                        
                        Spacer()
                        Text("RefId: \(order.id)")
                            .foregroundColor(.black)
                        
                        Spacer()
                        Text("CustId：\( order.userId)")
                            .foregroundColor(.black)
                            .padding(.leading)
                    }
                    
                    HStack{
                        Text("供应商: \(order.displayName)")
                            .foregroundColor(.black)
                        
                        Spacer()
                        Text(" \(order.phone)")
                            .foregroundColor(.black)
                        
                        Image("orer_phone").frame(width: 28, height: 28)
                    }
                    HStack{
                        Text(" \(order.coupon_status)")
                            .foregroundColor(.black)
                        
                        Spacer()
                        Text("订单金额:").foregroundColor(.black)
                        
                        Text("\(order.money_new    )")
                            .foregroundColor(Color("priceFontColor"))
                            .font(.system(size:20))
                            .bold()
                        
                        
                    }
                    
                    HStack{
                        if(order.delivery_option_value == "1"){
                            Text("客户自取 ")
                                .foregroundColor(.black)
                            
                        }else{
                            Text("商家送货")
                                .foregroundColor(.black)
                        }
                        
                        
                        Spacer()
                        Button(action: {
                            
                           orderVM.getOrderDetails(orderId: order.orderId, User_temp_tokens: userVM.user_temp_tokens)
                            
                           isShoworderDetails = true
                        }, label: {
                            Text("订单详情")  .padding(4)
                                .foregroundColor(.white)
                                .background(Color("mainBlue"))
                                .cornerRadius(4)
                        }).sheet(isPresented: $isShoworderDetails){
                            OrderDetailsView(orderId: order.orderId)
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
            
                    
                    
                    
                    
                }.padding(.bottom,10)
                
                Divider()
            }.padding(5)
                .cornerRadius(5)
        }
        
        
    }
    
}

