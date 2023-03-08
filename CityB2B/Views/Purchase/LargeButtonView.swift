//
//  LargeButtonView.swift
//  orderPage
//
//  Created by Fei Wang on 29/1/2023.
//

import SwiftUI

struct LargeButtonView: View {
    
    @EnvironmentObject var homePageVM: HomePageViewModel
    
    var title: String
    var bgColor: Color
    var displayView: Int = 0
    
    @State var displayHomepage : Bool = false
    @State var displayContinue : Bool = false
    
    var body: some View {
        
        NavigationLink(destination: SupplierView() .navigationBarHidden(true)
            .navigationBarTitle(""), isActive: $displayHomepage ) { EmptyView() } .navigationBarHidden(true)
            .navigationBarTitle("")
        
        NavigationLink(destination:  SupplierShopView(message: homePageVM.currentFactoryAndUserId!) .navigationBarHidden(true)
            .navigationBarTitle(""), isActive: $displayContinue ) { EmptyView() } .navigationBarHidden(true)
            .navigationBarTitle("")
       
        
        Button(action:{
//            print("go home")
            
            if(displayView == 1 ){
                
             
                displayHomepage = true
               
                
            }else if(displayView == 2){
                if(( homePageVM.currentFactoryAndUserId) != nil) {
                    displayContinue = true
                    
                }else{
                    
                }
               
            }else if(displayView == 3){
//                OrdersView()
            }else{
                print(" large button view it is not good ")
            }
            
           
        } , label: {
            Text(self.title)
                .frame(width:202, height: 39)
                   
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    .background(self.bgColor)
                    .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(self.bgColor, lineWidth: 10)
                            )
                    
            
        })
    }
    
   
  
}

