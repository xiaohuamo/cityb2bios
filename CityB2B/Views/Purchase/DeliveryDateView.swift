//
//  DeliveryOPtionView.swift
//  CityB2B
//
//  Created by Fei Wang on 7/2/2023.
//

import SwiftUI



struct DeliveryDateView: View {
    
    
    @Environment (\.presentationMode) var presentationMode
    
    //    @Binding var y: String currentDeliveryOptionValue
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    
    
    /*
     [
     {
     "orderEnd" : null,
     "delivery_morning" : null,
     "days" : "周三",
     "isAvaliable" : false,
     "orderStartTimestamp" : null,
     "delivery_anytime" : null,
     "isselected" : 0,
     "optionalDisplay" : "不可选",
     "orderDelivery" : null,
     "orderStart" : null,
     "disPlayDate" : "08-Feb",
     "orderEndTimestamp" : null,
     "delivery_afternoon" : null,
     "orderDeliveryTimestamp" : 1675814400
     },
     {
     "orderEnd" : "Wed, 08 Feb 2023 23:00:00 +0000",
     "delivery_morning" : 0,
     "days" : "周四",
     "isAvaliable" : true,
     "orderStartTimestamp" : 1675357200,
     "delivery_anytime" : 1,
     "isselected" : 0,
     "optionalDisplay" : "可选",
     "orderDelivery" : "Thu, 09 Feb 2023 00:00:00 +0000",
     "orderStart" : "Fri, 03 Feb 2023 04:00:00 +0000",
     "disPlayDate" : "09-Feb",
     "orderEndTimestamp" : 1675857600,
     "delivery_afternoon" : 0,
     "orderDeliveryTimestamp" : 1675900800
     }]
     
     
     
     
     */
    @State private var dataItems = [
        DeliveryDate(
            delivery_morning : 0,
            delivery_afternoon : 0,
            delivery_anytime : 1,
            orderStartTimestamp : 1675357200,
            orderEndTimestamp : 1675857600,
            orderDeliveryTimestamp : 1675900800,
            orderStart : "Fri, 03 Feb 2023 04:00:00 +0000",
            orderEnd : "Wed, 08 Feb 2023 23:00:00 +0000",
            orderDelivery : "Thu, 09 Feb 2023 00:00:00 +0000",
            isAvaliable : true,
            isselected : 0,
            days : "周四",
            disPlayDate : "09-Feb",
            optionalDisplay : "可选"
        ), DeliveryDate(
            delivery_morning : 0,
            delivery_afternoon : 0,
            delivery_anytime : 1,
            orderStartTimestamp : 1675357200,
            orderEndTimestamp : 1675857600,
            orderDeliveryTimestamp : 1675900800,
            orderStart : "Fri, 03 Feb 2023 04:00:00 +0000",
            orderEnd : "Wed, 08 Feb 2023 23:00:00 +0000",
            orderDelivery : "Thu, 09 Feb 2023 00:00:00 +0000",
            isAvaliable : true,
            isselected : 0,
            days : "周五",
            disPlayDate : "10-Feb",
            optionalDisplay : "可选"
        ) ,DeliveryDate(
            delivery_morning : 0,
            delivery_afternoon : 0,
            delivery_anytime : 1,
            orderStartTimestamp : 1675357200,
            orderEndTimestamp : 1675857600,
            orderDeliveryTimestamp : 1675900800,
            orderStart : "Fri, 03 Feb 2023 04:00:00 +0000",
            orderEnd : "Wed, 08 Feb 2023 23:00:00 +0000",
            orderDelivery : "Thu, 09 Feb 2023 00:00:00 +0000",
            isAvaliable : true,
            isselected : 0,
            days : "周六",
            disPlayDate : "11-Feb",
            optionalDisplay : "可选"
        )
        
        
    ];
    
    
    //记录选择的模型
    @State private var selection: DeliveryDate?
    @State private var selection1: DeliveryDate?
    @State private var displayWidth: CGFloat = 0
    @State private var displayHeight: CGFloat = 0
    @State private var widthAndHeight = ""
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            /*    HStack {
             Spacer()
             Button(action: {
             self.presentationMode.wrappedValue.dismiss()
             
             }, label: {
             Image(systemName: "xmark.circle.fill").resizable().aspectRatio(contentMode: .fit)
             .frame(width: 30, height: 30)
             
             
             })
             } */
            Group {
                
                HStack {
                    Spacer()
                    Text("选择配送时间")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                       
                    }, label: {
                        Image(systemName: "xmark.circle.fill").resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(.gray)
                        
                        
                    })
                }
                
                Divider().padding(.bottom, 15)
                VStack(){
                    HStack{
                        Spacer()
                        ForEach(self.deliveryDateVM.deliveryDate!,id:\.self){
                            selectModel in
                            
                            ZStack{
                                if( self.selection == nil) {
                                    
                                    if (selectModel.isselected == 1 ) {
                                        Rectangle(
                                        ).fill(Color("mainBlue")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                   
                                    }else{
                                        Rectangle(
                                        ).fill(Color(selectModel.backColor ?? "")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                    }
                                   
                                }else{
                                    
                                    if(self.selection?.disPlayDate == selectModel.disPlayDate ) {
                                        
                                        Rectangle(
                                        ).fill(Color("mainBlue")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                    }else{
                                        Rectangle(
                                        ).fill(Color(selectModel.backColor ?? "")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                    }
                                    
                                   
                                }
                               
                                   
                              
                                VStack{
                                    Spacer(minLength: 5)
                                    Text(selectModel.days ?? "")
                                        .font(.system(size: 16))
                                    Spacer(minLength: 3)
                                    Text(selectModel.optionalDisplay ?? "")
                                        .font(.system(size: 12))
                                    Spacer(minLength: 3)
                                    Text(selectModel.disPlayDate ?? "")
                                        .font(.system(size: 12))
                                    Spacer(minLength: 5)
                                }.foregroundColor(.white)
                                // 指定字体大小
                            }.onTapGesture{
                                if selectModel.isAvaliable == true {
                                    self.selection = selectModel
                                    let _ = print(" here is  \(String(describing: self.selection?.disPlayDate))")
                                    self.deliveryDateVM.resetAllselectedDeliveryDate(OrderDeliveryTimestamp : self.selection?.orderDeliveryTimestamp ?? 0)
                                    self.selection?.isselected = 1
                                    self.selection?.backColor = "mainBlue"
                                    self.createOrderVM.createOrder?.logistic_delivery_date = self.selection?.orderDeliveryTimestamp
                                    //                                    如果 下一行有被选择
                                    if( self.selection1?.isselected == 1 ){
                                        self.selection1 = nil
                                        
                                    }
                                }
                                
                               
           
                            }
                            
                            Spacer()
                        }
                    }
                    
                } .padding(.bottom, 40)
                
                Divider().padding(.bottom, 15)
                VStack(spacing:100){
                    HStack{
                        Spacer()
                        ForEach(self.deliveryDateVM.deliveryDate1!,id:\.self){
                            selectModel1 in
                            
                            ZStack{
                                if( self.selection1 == nil) {
                                    if (selectModel1.isselected == 1 ) {
                                        Rectangle(
                                        ).fill(Color("mainBlue")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                   
                                    }else{
                                        Rectangle(
                                        ).fill(Color(selectModel1.backColor ?? "")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                    }
                               
                                }else{
                                    
                                    if(self.selection1?.disPlayDate == selectModel1.disPlayDate ) {
                                        
                                        Rectangle(
                                        ).fill(Color("mainBlue")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                    }else{
                                        Rectangle(
                                        ).fill(Color(selectModel1.backColor ?? "")).frame(width: screenWidth/5.5, height: screenWidth/5.5)
                                    }
                                    
                                   
                                }
                               
                                   
                              
                                VStack{
                                    Spacer(minLength: 5)
                                    Text(selectModel1.days ?? "")
                                        .font(.system(size: 16))
                                    Spacer(minLength: 3)
                                    Text(selectModel1.optionalDisplay ?? "")
                                        .font(.system(size: 12))
                                    Spacer(minLength: 3)
                                    Text(selectModel1.disPlayDate ?? "")
                                        .font(.system(size: 12))
                                    Spacer(minLength: 5)
                                }.foregroundColor(.white)
                                // 指定字体大小
                            }.onTapGesture{
                                if selectModel1.isAvaliable == true {
                                    self.selection1 = selectModel1
                                    let _ = print(" here is  \(String(describing: self.selection1?.disPlayDate))")
                                    self.deliveryDateVM.resetAllselectedDeliveryDate(OrderDeliveryTimestamp : self.selection1?.orderDeliveryTimestamp ?? 0)
                                    
                                    self.selection1?.isselected = 1
                                    self.selection1?.backColor = "mainBlue"
                                    self.createOrderVM.createOrder?.logistic_delivery_date = self.selection1?.orderDeliveryTimestamp
                                    
                                    if( self.selection?.isselected == 1 ){
                                        self.selection = nil
                                      
                                    
                                    }
                                }
                                
                               
           
                            }
                            
                            Spacer()
                        }
                    }
                    
                } .padding(.bottom, 40)
                    
                
                Divider()
                
            }
            .padding(0)
            .frame(height: 50)
            
            
        }
        .padding(.horizontal, 10)
        .overlay(GeometryReader { geo -> AnyView in
            DispatchQueue.main.async{
                displayWidth = geo.size.width
                displayHeight = geo.size.height
                widthAndHeight = geo.size.debugDescription
                
                
                
            }
            
            return AnyView(EmptyView())
        })
        //                    Text("宽度：\(displayWidth)")
        //                    Text("高度：\(displayHeight)")
        //                    Text("宽高：\(widthAndHeight)")
        //        Text("宽高：\(deliveryDatecellWidth/6)")
    }
    
}


struct DeliveryDateView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryDateView()
    }
}
