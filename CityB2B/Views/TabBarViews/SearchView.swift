//
//  SearchView.swift
//  ShoppingApp
//
//  Created by kz on 14/11/2022.
//

import SwiftUI

enum Categories: String, CaseIterable{
    case smartphones = "Smartfony"
    case tablets = "Tablety"
    case laptops = "Laptopy"
    case headphones = "Słuchawki"
    case watches = "Zegarki"
    case accesories = "Akcesoria"
}

struct SearchView: View {
    
    @State var searchText = ""
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var shopCategoryVM: ShopCategoryViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    
    var body: some View {
        NavigationView{
            if self.productVM.products != nil{
                if self.searchText != "" && !self.searchText.isEmpty {
                    ScrollView{
                        LazyVStack{
                            ForEach(self.productVM.products!.filter{(self.searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.searchText))}, id: \.id){ product in
                                NavigationLink(destination: ProductDetailsView(product: product)) {
                                    SearchCell(product: product)}
                                
                                Divider()
                                    .overlay(Color.blue)

                            }
                            
                        }
                        
                    }

                }
                else {
                    HStack{
                        VStack(alignment: .leading){
                            List{
                                Section(){
                                   ForEach(self.shopCategoryVM.shopCategory!, id: \.id) { item in
                                        Button(action: {
                                            print("跳转到某个产品位置");
                                        }, label: {
                                            Text("\(item.title)")
                                        })
                                        
                                    }

                                }
                                
                            }
                            .listStyle(.grouped)
                            .scrollDisabled(true)
                            .scrollContentBackground(.hidden)

                        }.frame(width: 100)
                            .padding(.top,1)
                        VStack(alignment: .leading){
                            ScrollView{
                                LazyVStack{
                                    ForEach(self.productVM.products!, id: \.id){ product in
                                        NavigationLink(destination: ProductDetailsView(product: product)) {
                                            SearchCell(product: product)}
                                        
                                        Divider()
                                            .overlay(Color.blue)

                                    }
                                    
                                }
                                
                            }

                        }.frame(width:.infinity)
                            .padding(.top,1)
                            .padding(.bottom,35)
                        
                    }
                  
                    
                }
                
            }

        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("产品").font(.headline).bold()
            }
            
        }
        .background(.gray.opacity(0.1))
        .searchable(text: $searchText)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
        
    }

}

struct SearchByCategory: View{
    
    var category: String
    @EnvironmentObject var productVM: ProductViewModel
    @State var productCounter: Int = 0

    var body: some View{
        NavigationView{
            if productCounter > 0 {
                ScrollView{
                    LazyVStack{
                        VStack{
                            Text("发现 \(productCounter) 产品")
                            Divider()
                                .overlay(Color.blue)
                            if(self.productVM.products != nil){
                                ForEach(self.productVM.products!.filter{$0.category.contains(self.category) }, id: \.id) { product in
                                    SearchCell(product: product)
                                    Divider()
                                        .overlay(Color.blue)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            } else {
                Text("当前品类无产品！")
                Spacer()
            }
            
        }
        .onAppear{
            self.productCounter = self.productVM.products!.filter{$0.category.contains(self.category) }.count
        }

        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(category)
    }

}

struct SearchCell: View{
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        HStack{
            ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
            VStack{
                Text(product.name)
                    .lineLimit(2)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                    .foregroundColor(.black)
                HStack{
                    Button {
                        productVM.addProductToCart(productID: product.id)
                    } label: {
                        HStack() {
                               Image(systemName: "cart.badge.plus")
                                .bold().font(.callout)
                               Text("购买")
                                .bold().font(.footnote)
                           }

                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(45)
                           
                    }
                    Spacer()
                    if product.isOnSale{
                        VStack{
                            Text("\(product.price)")
                                .bold()
                               .padding([.top, .leading, .trailing])
                                .font(.callout)
                                .strikethrough()
                                .foregroundColor(.black).opacity(0.75)
                                .frame(alignment: .trailing)

                            Text("$\(product.onSalePrice)")
                                .padding([.leading,.trailing])
                                .foregroundColor(.black)
                        }
                        .frame(alignment: .center)
                    }
                    else {
                        Text("$\(product.price)")
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                }

            }

        }
        
    }
    
}

struct ProductSearchCellImage: View {
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
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
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

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(product: Product.sampleProduct)
            .environmentObject(ProductViewModel())
    }
}
