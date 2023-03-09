

import SwiftUI

struct NewSupplierView: View {
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var mysupplierVM:SupplierViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        
        VStack{
            List{
                HStack{
                    Image("me-supplier").frame(width: 36,height: 36)
                        .padding(.top,3)
                        .padding(.bottom,3)
                   Spacer(minLength: 10)
                    NavigationLink(destination: JoinWithCodeView()) {
                        Text("邀请码加入")
                    }
                    Spacer()
                }
                HStack{
                    Image("archivedsupplier").frame(width: 36,height: 36)
                        .padding(.top,3)
                        .padding(.bottom,3)
                   Spacer(minLength: 10)
                    NavigationLink(destination: OrdersView()) {
                        Text("扫一扫加入")
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
           
            if(mysupplierVM.myNewSuppliers?.isEmpty == false ){
                ScrollView{
                    
                    List{
                        
                        ForEach(self.mysupplierVM.myNewSuppliers! ,id: \.id) { myNewSupplier in
                            
                            SupplierCell2(myNewSupplier: myNewSupplier)
                            
                        }
                      
                       
                         
                    }.background(Color("backgroundCat"))
                    .listStyle(.grouped)
                    .scrollDisabled(true)
                    .scrollContentBackground(.hidden)
                    .frame(height: 1000)
                    .listRowInsets(EdgeInsets()) //
                   
                }
            }else{
                Spacer()
                Text("当前无新供应商")
                    .foregroundColor(.gray)
                Spacer()
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
           
            self.mysupplierVM.getMyNewsupplierList(User_temp_tokens:user.user_temp_tokens)
            self.homePageVM.getHomePageInfo(User_temp_tokens: user.user_temp_tokens)
         
            
        }
        
        Spacer()
    }
    }

struct SupplierCell2: View{
    
    var myNewSupplier: MyNewSupplier?
    
    @EnvironmentObject var mysupplierVM:SupplierViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var user: UserViewModel
   
    @State private var processingStatus : Int = 0
    var body: some View{
        HStack{
           
            CellImage2(imageURL: (myNewSupplier?.logo)!)

                .padding(.top,3)
                .padding(.bottom,3)
                .padding(.leading,5)
            VStack{
                HStack{
                    Text(myNewSupplier?.displayName ?? "").padding(.top,3)
                        .foregroundColor(Color("fontColorMain"))
                        .padding(.leading,5)
                        Spacer()

                }
               
                HStack{
                   
                    Image(systemName: "phone")
                       .foregroundColor(.green)
                              .frame(width: 5,height: 5)
                              .padding(.leading,10)
                              .padding(.trailing,5)
                    
                    Text(myNewSupplier?.phone ?? "")
                        .font(.system(size: 14))
                        .foregroundColor(Color("grey1"))
                        .frame(height:12,alignment: .leading)
                        .padding(.top,0)
                    Spacer()
                }
                
            }.frame(width: .infinity,height: 45)
            Spacer()
            VStack{
                if(processingStatus == 0) {
                    HStack{
                        
                        
                        
                        Button(action: {
                            self.mysupplierVM.clientIsAgreeJoinSupplier(User_temp_tokens: user.user_temp_tokens, factory_id: myNewSupplier?.id.codingKey.stringValue ?? "0", user_id: myNewSupplier?.user_id.codingKey.stringValue ?? "0", status1: "1") { result in
                                processingStatus = result
                            }
                        }, label: {
                            Text("同意")
                                .foregroundColor(.white)
                        })
                        .padding(8)
                           
                            .background(Color("mainBlue"))
                            
                        Button(action: {
                            self.mysupplierVM.clientIsAgreeJoinSupplier(User_temp_tokens: user.user_temp_tokens, factory_id: myNewSupplier?.id.codingKey.stringValue ?? "0", user_id: myNewSupplier?.user_id.codingKey.stringValue ?? "0", status1: "1") { result in
                                processingStatus = result
                            }
                        }, label: {
                            Text("同意")
                                .foregroundColor(.white)
                        }).padding(8)
                          
                            .background(Color("priceFontColor"))
                            
                        
                    }
                }else if (processingStatus == 1 ){
                    HStack{
                        Text("已添加")
                    }
                }else if(processingStatus == 2 ) {
                    HStack{
                        Text("审核未通过")
                    }
                }else{
                    HStack{
                        Text("未知")
                    }
                }
               
            }
            
           
        }.onAppear{
            processingStatus = myNewSupplier?.status ?? 0
        }
         
    }
 }

struct CellImage2: View {
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


struct NewSupplierView_Previews: PreviewProvider {
    static var previews: some View {
        SupplierCell2(myNewSupplier: MyNewSupplier.sampleMyNewSupplier).environmentObject(UserViewModel())
            .environmentObject(SupplierViewModel())
    }
}
