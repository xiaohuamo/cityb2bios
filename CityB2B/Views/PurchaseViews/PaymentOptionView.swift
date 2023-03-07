//
//  PaymentOptionView.swift
//  CityB2B
//
//  Created by Fei Wang on 7/2/2023.
//



import SwiftUI



struct PaymentOptionView: View {
    
//    @Binding var y: String currentDeliveryOptionValue
    
    @EnvironmentObject var purchaseVM: PurchaseViewModel
    @Environment (\.presentationMode) var presentationMode

     
    /*
     "pay_way": [{
     "payment_option_value": "Cash On Delivery",
     "is_default": 1,
     "payment": "offline",
     "pay_way": "Offline payment",
     "pay_desc": "Offline Payments allow you to pay the order via pay in store or transfer money to bank account etc ."
 }]
     
     
    
    
       
    @State private var dataItems = [
        Delivery_way(is_default: 1, delivery_option: 1,delivery_option_value: "Seller delivery" ,delivery_desc:  "Please be Advised , that when delivery ,please make sure the address can be accessed .\r\n"),Delivery_way(is_default: 0, delivery_option: 2,delivery_option_value: "Customer picking up " ,delivery_desc:  "Please be Advised , that when delivery ,please make sure the address can be accessed .\r\n")
     ];
    
   */
    //记录选择的模型
    @State private var selection:Pay_way?;
    

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
                    Text("选择支付方式")
                        .font(.headline)
                    Spacer()
                }
                
                ForEach(self.purchaseVM.purchaseInfo!.pay_way,id:\.self){ selectModel in
                    
                    HStack{
                        
                        Text(selectModel.payment_option_value ?? "")
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
                        let _ = print(" here is  \(String(describing: self.selection?.payment_option_value))")
                        
                        
                        //                        self.selection?.is_default = 1
                        //                        self.presentationMode.wrappedValue.dismiss()
                        //                        ||  selectModel.is_default  == 1
                    }
                    
                }
                
            }
            .padding(0)
            .frame(height: 50)
            
            
        }
        .padding(.horizontal, 10)
    }
}




struct PaymentOptionView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOptionView()
    }
}
