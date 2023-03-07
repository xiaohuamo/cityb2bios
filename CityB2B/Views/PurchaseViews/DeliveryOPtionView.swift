//
//  DeliveryOPtionView.swift
//  CityB2B
//
//  Created by Fei Wang on 7/2/2023.
//

import SwiftUI



struct DeliveryOPtionView: View {
    
//    @Binding var y: String currentDeliveryOptionValue
    
    @EnvironmentObject var createOrderVM: CreateOrderViewModel
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    @Environment (\.presentationMode) var presentationMode

     
    /*
     "delivery_way": [{
                 "is_default": 1,
                 "delivery_option": 1,
                 "delivery_option_value": "Seller delivery",
                 "delivery_desc": "Please be Advised , that when delivery ,please make sure the address can be accessed .\r\n"
             }, {
                 "is_default": 0,
                 "delivery_option": 2,
                 "delivery_option_value": "Self pickup",
                 "delivery_desc": "picking up time is from 12 oclick to 1 oclock ."
             }]
     
     
    
    
       
    @State private var dataItems = [
        Delivery_way(is_default: 1, delivery_option: 1,delivery_option_value: "Seller delivery" ,delivery_desc:  "Please be Advised , that when delivery ,please make sure the address can be accessed .\r\n"),Delivery_way(is_default: 0, delivery_option: 2,delivery_option_value: "Customer picking up " ,delivery_desc:  "Please be Advised , that when delivery ,please make sure the address can be accessed .\r\n")
     ];
    
   */
    //记录选择的模型
    @State private var selection:Delivery_way?;
    

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                    Text("选择物流方式")
                        .font(.headline)
                    Spacer()
                }
                
                ForEach(self.purchaseVM.purchaseInfo!.delivery_way,id:\.self){ selectModel in
                    
                    HStack{
                      
                        Text(selectModel.delivery_option_value ?? "")
                            .font(.system(size: 16))
                        Spacer()
                        if(selectModel.is_default == 1 && self.selection == nil) {
                            Image(systemName:  "checkmark.circle.fill" )
                                .font(.title)
                                .foregroundColor(.blue)
                        }else{
                            Image(systemName: (self.selection
                                               == selectModel ) ? "checkmark.circle.fill" :"circle" )
                            .font(.title)
                            .foregroundColor(.blue)
                        }
                        
                    }.onTapGesture{
                        self.selection = selectModel
                     
//                        delivery_option
                       self.createOrderVM.createOrder?.delivery_option = self.selection?.delivery_option
                        self.purchaseVM.currentDeliverOption = self.selection?.delivery_option
                        self.purchaseVM.currentDeliverOptionValue = self.selection?.delivery_option_value
                        self.purchaseVM.currentDeliverOptionDesc = self.selection?.delivery_desc
                     }
                    
                    
                }
                
            }
            .padding(0)
            .frame(height: 50)
            
            
        }
        .padding(.horizontal, 10)
    }
}


struct DeliveryOPtionView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryOPtionView()
    }
}
