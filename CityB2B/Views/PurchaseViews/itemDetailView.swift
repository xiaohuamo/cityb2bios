//
//  NormalExample.swift
//  PartialSheetExample
//
//  Created by Andrea Miotto on 29/4/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI




struct itemDetailView: View {
  
    @EnvironmentObject var itemVM: ItemViewModel
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var userVM: UserViewModel
    var item : ProductInfo
    @Environment(\.presentationMode) var presentationMode
    
    @State private var currentIndex: Int = 0
    
    @State public  var itemQuantity: Int = 0
    @State  var buttonSelected: Int?
    @State public  var currentGuige_ids: Int = 0
    @State public var menuHeight: CGFloat = 100.00
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    Text("选择规格")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color("grey1"))
                            .aspectRatio(contentMode: .fit).frame(width: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                     })
                    
                    
                    
                }.padding(.top)
                HStack{
                    if(item.menu_pic?.count ?? 0 > 0){
                        TabView(selection: $currentIndex){
                            ForEach(0..<(item.menu_pic?.count ?? 0), id: \.self){ index in
                                ItemImage(imageURL: URL(string: item.menu_pic ?? "")!)
                                    .tag(index)
                            }
                            
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                        .frame(minHeight: 300)
                        
                        .onAppear{
                            UIPageControl.appearance().currentPageIndicatorTintColor = .black
                            UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
                        }
                        
                    }
                    else {
                        ProductImage(imageURL: item.imageURL)
                        
                    }
                }
                HStack{
                    Text(item.title ?? "")
                        .font(.body)
                        .lineLimit(2)
                        .bold()
                        .font(.system(size:16))
                    Spacer()
                    Text("\(String(format: "%.2f", item.price ) )")
                        .font(.system(size:20))
                        .lineLimit(2)
                        .bold()
                        .foregroundColor(Color("priceFontColor"))
                    Text("\(String(format: "%.2f", item.old_price ) )")
                        .strikethrough()
                        .foregroundColor(.gray).opacity(0.75)
                }
                HStack{
                    Text(item.guige_des1?.category_name ?? "")
                        .font(.body)
                        .lineLimit(2)
                    
                }
                HStack{
                    VStack{
                        GeometryReader {  geometry in
                            self.generateContent(menu_list :  item.menu_option_list! ,in: geometry)
                        }.frame(height: 130)
                            
                    }
//                    menuHeight
                   
                }
               Spacer(minLength: 50)
                   
                
                HStack{
                    Spacer()
                    
                    Button {
                        itemQuantity = itemQuantity-1
                        if(itemQuantity < 0) { itemQuantity = 0 }
                      
                        print("ready to add \(item.id)")
                    } label: {
                        HStack() {
                            Image( "jian")
                                .bold().font(.callout)
                            
                        }
                        
                        .padding(1)
                        .foregroundColor(.white)
                        
                        
                        
                    }
                    
                    TextField("", value: $itemQuantity, format: .number)
                        .textFieldStyle(.roundedBorder)
                    
                    
                        .frame(width: 55,height: 25)
                        .foregroundColor(Color("fontColorMain"))
                        
                        .keyboardType(.numberPad)
                    
                    Button {
                        
                        itemQuantity = itemQuantity + 1
                       
                        print("ready to add \(item.id)")
                    } label: {
                        HStack() {
                            Image("jia")
                                .bold().font(.callout)
                            
                        }
                        
                        .padding(1)
                        .foregroundColor(.white)
                        
                        
                    }
                }
                
                Divider()
                Spacer(minLength: 20)
                HStack{
                    Button {
                        cartVM.addItemToCart(itemId: item.id,factoryAndUser:self.homePageVM.currentFactoryAndUserId!,User_temp_tokens :    userVM.user_temp_tokens,Number:itemQuantity,guige_ids:currentGuige_ids)
                        
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack{
                            Image(systemName: "eye").bold().font(.body)
                            Text("加入购物车").bold().font(.body)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(45)
                    }
                    .padding([.leading, .trailing, .bottom])
                }
              
                
            }
            .padding(.horizontal, 10)
            .onAppear{
                //            itemVM.getProductInfo(factoryAndUser: self.homePageVM.currentFactoryAndUserId!,User_temp_tokens: userVM.user_temp_tokens, id: item.id)
            }
            
        }
       
    }
    
    private func generateContent(menu_list : [MenuOptionList] ,in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(menu_list, id: \.self) { platform in
                Button(action: {
                    self.buttonSelected = platform.id
                    currentGuige_ids = platform.id ?? 0
                //    print(" current optionid is \(platform.id ?? 110)")
                    
                }, label: {
                    Text(platform.menu_name)
                })
                .padding()
                .fixedSize()
                //                            .border(Color.black)
                
                .foregroundColor(self.buttonSelected ?? 0 == platform.id ? Color.white  : Color("fontColorMain"))
                
                .background(self.buttonSelected ?? 0 == platform.id ? Color("mainBlue") : Color.white)
                .border(self.buttonSelected ?? 0 == platform.id ? Color("mainBlue") : Color("fontColorMain"))
                .cornerRadius(4)
              
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == menu_list.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == menu_list.last! {
                            height = 0 // last item
                        }
                       
                      
                        return result
                    })
            }
        }
        
       
    }

    
}

struct itemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            itemDetailView( item:ProductInfo.sampleProductInfo).environmentObject(UserViewModel())
                .environmentObject(HomePageViewModel())
                .environmentObject(ItemViewModel())
        }
       
    }
}
