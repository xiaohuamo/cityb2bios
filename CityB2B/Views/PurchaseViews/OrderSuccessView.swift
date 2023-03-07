//
//  oderSuccessView.swift
//  orderPage
//
//  Created by Fei Wang on 30/1/2023.
//

import SwiftUI

struct OrderSuccessView: View {
    var body: some View {
        ZStack{
            VStack{
                    VStack{
                        HStack{
                        Image("TickOkBlue")
                    }
                   
                   VStack{
                        Text("恭喜您，下单成功")
                    }
                 }
                .frame(maxWidth: .infinity)
                .frame(height: 279)
                .background(.white)
                .padding(15)
                Spacer()
                   
                    
            }.zIndex(99)
                .padding(.top,33)
             
            VStack{
                HStack{
                    
                }
                .frame(height: 244)
                .frame(maxWidth: .infinity)
                .background(Color("mainBlue"))
                
                VStack{
                    Spacer(minLength: 195)
                    HStack{
                        LargeButtonView(title: "返回首页", bgColor: Color("mainBlue"),displayView: 1)
                    } .padding(.bottom,15)
                  
                    HStack{
                        LargeButtonView(title: "查看订单", bgColor: Color("mainBlue"),displayView:3)
                    } .padding(.bottom,15)
                  
                    HStack{
                        LargeButtonView(title: "继续购物", bgColor: Color("mainBlue"),displayView: 2)
                    } .padding(.bottom,15)
                    
                
                    Spacer(minLength: 50)
                    }
                  
               
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("gray2"))
        }
    }
    }



struct OrderSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSuccessView()
    }
}
