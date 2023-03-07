//
//  MainView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

struct MainView: View {
//    声明两个全局变量
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    var body: some View {
        NavigationView{
            
            
            VStack{
//                使用scrolview 做滚动效果，下面使用VStack 排版，并从推荐库中获得产品
//                 并且使用 productcarousel进行强制转换和显示
                ScrollView(.vertical){
                    
                    
                    VStack(alignment: .leading){
                        if(productVM.promotedProducts != nil){
                            ProductCarousel(products: productVM.promotedProducts ?? (productVM.products)!)
                        }
                    }
                    
                   
                    VStack(alignment: .leading){
                        
                        if(productVM.onSaleProducts != nil){
                            ProductCardList(products: productVM.onSaleProducts!)
                        }
                        
                    }
                    Spacer(minLength: 20)
                    
                    VStack(alignment: .leading){
                        Text("促销")
                            .font(.system(size:20))
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        if(productVM.onSaleProducts != nil){
                            ProductCardList(products: productVM.onSaleProducts!)
                        }
                        
                    }
                    Spacer(minLength: 20)
                }
                                
            }
            .navigationBarTitle("CityB2B")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: LeadingBarItem, trailing: TrailingBarItem)
        }

        .onAppear{
            productVM.getPromotedProducts()
            productVM.getOnSaleProducts()
            productVM.getProducts()
//            productVM.getUserWatchList()
//            productVM.getUserCart()
        }
        
        .alert(isPresented: $userVM.showingAlert){
            Alert(
                title: Text(userVM.alertTitle),
                message: Text(userVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
        .alert(isPresented: $productVM.showingAlert){
            Alert(
                title: Text(productVM.alertTitle),
                message: Text(productVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }

    }
    var  LeadingBarItem: some View{
        
        Button(
        action: {},
        label: {
            HStack(alignment: .firstTextBaseline) {
                Image( "blue")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    
                
                
            }
        })
    }

    var  TrailingBarItem: some View{
        HStack(alignment: .center,spacing: 20) {
            Button(
                action: {},
                label: {
                    
                    Image(systemName:  "arrow.up.forward.circle")
                        .foregroundColor(.black)
                })
            
            Button(
                action: {},
                label: {
                    
                    Image(systemName:  "plus")
                        .foregroundColor(.black)
                    
                    
                })
        }
    }

}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
