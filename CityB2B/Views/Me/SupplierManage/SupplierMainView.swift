//
//  SupplierMainView.swift
//  CityB2B
//
//  Created by Fei Wang on 28/2/2023.
//

import SwiftUI

struct SupplierMainView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var mysupplierVM:SupplierViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        
        VStack{
            List{
                HStack {
                    ZStack(alignment: .topTrailing) {
                        Image("me-supplier")
                            .frame(width: 36, height: 36)
                            .padding(.top, 3)
                            .padding(.bottom, 3)
                        if(self.mysupplierVM.newSupplierCount != 0 ) {
                            Text("\(self.mysupplierVM.newSupplierCount )")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 5, y: -5)
                        }
                       
                    }
                    Spacer(minLength: 10)
                    NavigationLink(destination: NewSupplierView()) {
                        Text("新供应商")
                    }
                    Spacer()
                }

                HStack{
                    Image("archivedsupplier").frame(width: 36,height: 36)
                        .padding(.top,3)
                        .padding(.bottom,3)
                   Spacer(minLength: 10)
                    NavigationLink(destination: OrdersView()) {
                        Text("归档供应商")
                    }
                    Spacer()
                   
                }
                 
            }.background(Color("backgroundCat"))
            .listStyle(.grouped)
            .scrollDisabled(true)
            .scrollContentBackground(.hidden)
            .frame(height: 150)
            .listRowInsets(EdgeInsets())
            .padding(.bottom,20)// 去除列表行的边距
           
            if(mysupplierVM.mySuppliers?.isEmpty == false ){
                ScrollView{
                    
                    List{
                        if(self.mysupplierVM.mySuppliers != nil) {
                            
                            ForEach(self.mysupplierVM.mySuppliers! ,id: \.id) { mySupplier in
                                
                                SupplierCell(mySupplier: mySupplier)
                                
                            }
                          
                        }
                       
                       
                         
                    }.background(Color("backgroundCat"))
                    .listStyle(.grouped)
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .frame(height: 1000)
                    .listRowInsets(EdgeInsets()) //
                   
                }
            }else{
                Text("当前无供应商")
            }
            Spacer()
            
        }
        .navigationBarTitle("供应商", displayMode: .inline) // 设置导航栏标题的显示模式为 inline
        .navigationBarBackButtonHidden(true) // 隐藏返回按钮上的文字
        
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.blue)
                Text("") // 空文本占位符
            }
        )
        .onAppear{
            self.mysupplierVM.getMysupplierList(User_temp_tokens: user.user_temp_tokens, type: "1")
            self.mysupplierVM.getMyNewsupplierList(User_temp_tokens:user.user_temp_tokens)
            self.homePageVM.getHomePageInfo(User_temp_tokens: user.user_temp_tokens)
            self.mysupplierVM.newSupplierCount(User_temp_tokens:user.user_temp_tokens)
            
        }
        
        Spacer()
    }
    }

struct SupplierCell: View{
    
    var mySupplier: MySupplier?
    
    @EnvironmentObject var mysupplierVM:SupplierViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    
    var body: some View{
        HStack{
           
            CellImage1(imageURL: (mySupplier?.logo)!)

                .padding(.top,3)
                .padding(.bottom,3)
                .padding(.leading,5)
            VStack{
                HStack{
                    
                    NavigationLink(destination: SupplierShopView(message:findFactoryByID(mySupplier!.id)!)) {
                        Text(mySupplier?.displayName ?? "").padding(.top,3)
                            .foregroundColor(Color("fontColorMain"))
                           
                    }
                    Spacer()
                }
               
                HStack{
                   
                    Image(systemName: "phone")
                       .foregroundColor(.green)
                              .frame(width: 5,height: 5)
                              .padding(.leading,10)
                              .padding(.trailing,5)
                    
                    Text(mySupplier?.phone ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(Color("grey1"))
                        .frame(height:12,alignment: .leading)
                        .padding(.top,0)
                    Spacer()
                }
                
            }.frame(width: .infinity,height: 45)
          
            
            Spacer()
        }
         
    }
    
    func findFactoryByID(_ id: Int) -> CurrentUserFactorys? {
            // iterate over the factory list to find a match
            for factory in homePageVM.factorylistsOfCurrentUser {
                if factory.id == id {
                    return factory
                }
            }
            // if no match found, return nil
            return nil
        }
    
  
    
}

struct CellImage1: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    let imageHeight: CGFloat? = 36
    let imageWidth: CGFloat? = 36
    let Radius: CGFloat? = 2
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: imageWidth, height: imageHeight, alignment: .center)
                .cornerRadius(Radius ?? 4)
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
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(Radius ?? 4)
                                    .padding(1)
                                Spacer()
                            }
                        }
                    }
                )
        }
        .cornerRadius(Radius ?? 4)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
        
    }
    
}


struct SupplierMainView_Previews: PreviewProvider {
    static var previews: some View {
        SupplierCell(mySupplier: MySupplier.sampleMySupplier).environmentObject(UserViewModel())
            .environmentObject(SupplierViewModel())
    }
}
