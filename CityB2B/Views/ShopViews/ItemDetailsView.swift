//
//  ProductDetails.swift
//  ShoppingApp
//
//  Created by kz on 23/11/2022.
//

import SwiftUI

struct ItemDetailsView: View {
    
    var item: Item
    
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
   
    @State private var currentIndex: Int = 0
    
    @State private var quantity: Int = 0
    
    
    
    var body: some View {
        ScrollView{
            VStack{
                if(item.menu_pic.count > 0){
                    TabView(selection: $currentIndex){
                        ForEach(0..<item.menu_pic.count, id: \.self){ index in
                            ItemImage(imageURL: URL(string: item.menu_pic)!)
                                .tag(index)
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(minHeight: 350)
                    
                    .onAppear{
                        UIPageControl.appearance().currentPageIndicatorTintColor = .black
                        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
                    }
                    
                }
                else {
                    ProductImage(imageURL: item.imageURL)
                    
                }
                
                Spacer()
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.5), radius: 3, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .center){
                        Text(item.title.uppercased())
                            .font(.title3).bold()
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .padding()
                            .id(item.id)
                        
                        HStack{
                            if (item.onSpecial != 0){
                                
                                VStack{
                                    Text("\( item.price ?? 0.00)")
                                        .bold()
                                        .padding([.leading, .trailing])
                                        .font(.callout)
                                        .strikethrough()
                                        .foregroundColor(.black).opacity(0.75)
                                        .frame(alignment: .trailing)
                                    
                                    Text("$\(item.price ?? 0.00)")
                                        .font(.headline)
                                    
                                }
                                .frame(alignment: .center)
                                .padding([.bottom, .leading, .trailing])
                            }
                            else {
                                Text("$\(item.price ?? 0.00)")
                                    .bold()
                                    .font(.headline)
                                    .padding([.bottom, .leading, .trailing])
                            }
                            
                            
                            
                        }
                        HStack{
                            
                            Button {
                                cartVM.addItemToCart(itemId: item.id,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:quantity,guige_ids:0)
                                print("ready to add \(item.id)")
                            } label: {
                                
                                HStack{
                                    Image(systemName: "cart.badge.plus").bold().font(.body)
                                    Text("购买").bold().font(.body)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(45)
                                
                            }
                            .padding([.leading, .trailing])
                            
                            Button {
                                //                                productVM.addProductToWatchList(productID: product.id)
                            } label: {
                                
                                HStack{
                                    Image(systemName: "eye").bold().font(.body)
                                    Text("关注").bold().font(.body)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(45)
                                
                            }
                            .padding([.leading, .trailing])
                            
                        }
                        
                        Text("Opis")
                            .bold()
                            .font(.title2)
                            .padding()
                        
                        Text(item.subtitle ?? "")
                            .foregroundColor(.black).opacity(0.75)
                            .padding([.leading, .trailing, .bottom])
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .lineLimit(100)
                        if(!item.menu_desc.isEmpty){
                            Text("详细")
                                .bold()
                                .font(.title2)
                                .padding()
                            
                            Divider()
                            
                            Text(item.menu_desc)
                            
                                .padding(.horizontal, 8)
                        }
                        
                        
                        
                        
                    }
                    
                    Spacer()
                    
                }
                
            }
            Button {
                //                    productVM.addProductToCart(productID: product.id)
            } label: {
                
                HStack{
                    Image(systemName: "cart.badge.plus").bold().font(.body)
                    Text("加入购物车").bold().font(.body)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(45)
                
            }
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        }
     .alert(isPresented: $userVM.showingAlert){
            Alert(
                title: Text(userVM.alertTitle),
                message: Text(userVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(isPresented: $itemVM.showingAlert){
            Alert(
                title: Text(itemVM.alertTitle),
                message: Text(itemVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
        
    }
    
}
    


struct ItemImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 300, height: 300, alignment: .center)
                .cornerRadius(14)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}
struct ItemImage100: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 130, height: 130, alignment: .center)
                .cornerRadius(4)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(4)
                                    .padding(1)
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(4)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}




struct ItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailsView(item: Item.sampleItem)
            .environmentObject(ItemViewModel())

    }
}
