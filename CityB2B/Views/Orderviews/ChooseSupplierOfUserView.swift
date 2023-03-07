//
//  ChooseSupplierOfUserView.swift
//  CityB2B
//
//  Created by Fei Wang on 23/2/2023.
//
//
//  DeliveryOPtionView.swift
//  CityB2B
//
//  Created by Fei Wang on 7/2/2023.
//

import SwiftUI



struct ChooseSupplierOfUserView: View {
    
//    @Binding var y: String currentDeliveryOptionValue
    
    @EnvironmentObject var user: UserViewModel
  
    @EnvironmentObject var homePageVM: HomePageViewModel
  
    @EnvironmentObject var orderVM: OrderViewModel
 
    //记录选择的模型
    @State private var selection : CurrentUserFactorys?
    
    @Environment (\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
           
            if(self.homePageVM.factorylistsOfCurrentUser.isEmpty == false ) {
                Group {
                    
                    HStack {
                        Spacer()
                        Text("选择供应商")
                            .font(.headline)
                        Spacer()
                    }
                    
                    ForEach(self.homePageVM.factorylistsOfCurrentUser,id:\.self){ selectModel in
                        
                        HStack{
                            
                            Text(selectModel.displayName )
                                .font(.system(size: 16))
                            Spacer()
                            
                            Image(systemName: (self.selection
                                               == selectModel ) ? "checkmark.circle.fill" :"circle" )
                            .font(.title)
                            .foregroundColor(.blue)
                            
                            
                        }.onTapGesture{
                            self.selection = selectModel
                           var aa = self.selection?.id.codingKey.stringValue
                            var bb = self.selection?.displayName
                            
                           orderVM.supplier_id = aa ?? ""
                            orderVM.supplier_name = bb ?? ""
                            orderVM.getUserOrders(factoryId:self.orderVM.supplier_id,start_time: orderVM.searchStartDate,end_time: orderVM.searchEndDate, User_temp_tokens :    user.user_temp_tokens)
                            dismiss()
                        }
                        
                        
                    }
                    
                }
                .padding(0)
                .frame(height: 50)
                
            }
            }
                .padding(.horizontal, 10)
        }
   
}


struct ChooseSupplierOfUserView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseSupplierOfUserView()
    }
}


