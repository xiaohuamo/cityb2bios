//
//  DeliveryDateOPtionView.swift
//  CityB2B
//
//  Created by Fei Wang on 8/2/2023.
//

import SwiftUI

struct DeliveryDateOPtionView: View {

    
//    @Binding var y: String currentDeliveryOptionValue
    
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    @EnvironmentObject var deliveryDate: DeliveryDateViewModel
    
    @Environment (\.presentationMode) var presentationMode

     
    /*
     {
             "delivery_morning": null,
             "delivery_afternoon": null,
             "delivery_anytime": null,
             "orderStartTimestamp": null,
             "orderEndTimestamp": null,
             "orderDeliveryTimestamp": 1675728000,
             "orderStart": null,
             "orderEnd": null,
             "orderDelivery": null,
             "isAvaliable": false,
             "isselected": 0,
             "days": "TUE",
             "disPlayDate": "07-Feb",
             "optionalDisplay": "No Delivery"
         }
     
    
    
       
    @State private var dataItems = [
        Delivery_way(is_default: 1, delivery_option: 1,delivery_option_value: "Seller delivery" ,delivery_desc:  "Please be Advised , that when delivery ,please make sure the address can be accessed .\r\n"),Delivery_way(is_default: 0, delivery_option: 2,delivery_option_value: "Customer picking up " ,delivery_desc:  "Please be Advised , that when delivery ,please make sure the address can be accessed .\r\n")
     ];
    
   */
    //记录选择的模型
    @State private var selection: DeliveryDate?
    

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
                    Text("选择配送日期")
                        .font(.headline)
                    Spacer()
                }
                
                /*
                 {
                         "delivery_morning": null,
                         "delivery_afternoon": null,
                         "delivery_anytime": null,
                         "orderStartTimestamp": null,
                         "orderEndTimestamp": null,
                         "orderDeliveryTimestamp": 1675728000,
                         "orderStart": null,
                         "orderEnd": null,
                         "orderDelivery": null,
                         "isAvaliable": false,
                         "isselected": 0,
                         "days": "TUE",
                         "disPlayDate": "07-Feb",
                         "optionalDisplay": "No Delivery"
                     }
                 */
                
                ForEach(self.deliveryDate,id:\.self){ selectModel in
                    
                    HStack{
                        
//                        Text(selectModel.disPlayDate ?? "")
//                            .font(.system(size: 16))
                        Spacer()
                        if(selectModel.isselected == 1 && self.selection == nil) {
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
//                        let _ = print(" here is  \(String(describing: self.selection?.disPlayDate))")
    
                    }
                    
                }
                
            }
            .padding(0)
            .frame(height: 50)
            
            
        }
        .padding(.horizontal, 10)
    }
}


struct DeliveryDateOPtionView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryDateOPtionView()
    }
}
