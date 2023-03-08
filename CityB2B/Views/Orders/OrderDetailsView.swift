import SwiftUI

struct OrderDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    let formatter = NumberFormatter()
    
//    let orderDetails: OrderDetails
    let orderId: String
    var body: some View {
        NavigationView {
            
            if(orderVM.orderDetails != nil ) {
                
                ScrollView {
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Section(header:
                            Text("Order Information")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.leading, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("mainBlue")).clipShape(RoundedRectangle(cornerRadius: 10)))
                        )  {
                            HStack {
                                Text("Invoice ID:")
                                    .foregroundColor(Color("fontColorMain"))
                                Spacer()
                                Text(orderVM.orderDetails?.orderInfo.invoiceId ?? "")
                                    .foregroundColor(Color("fontColorMain"))
                            }
                            HStack {
                                Text("Reference ID:")
                                    .foregroundColor(Color("fontColorMain"))
                                Spacer()
                                
                                Text(formatter.string(from: NSNumber(value: orderVM.orderDetails?.orderInfo.id ?? 0)) ?? "")
                               
                                    .foregroundColor(Color("fontColorMain"))
                            }
                            
                            HStack {
                                Text("Order ID:")
                                    .foregroundColor(Color("fontColorMain"))
                                Spacer()
                                Text(orderVM.orderDetails?.orderInfo.orderId ?? "")
                                    .foregroundColor(Color("fontColorMain"))
                            }
                            HStack {
                                Text("Order Name:")
                                    .foregroundColor(Color("fontColorMain"))
                                Spacer()
                                Text(orderVM.orderDetails?.orderInfo.orderName ?? "") .foregroundColor(Color("fontColorMain"))
                            }
                            HStack {
                                Text("Create Time:")
                                    .foregroundColor(Color("fontColorMain"))
                                Spacer()
                                Text(orderVM.orderDetails?.orderInfo.createTime ?? "") .foregroundColor(Color("fontColorMain"))
                            }
                            HStack {
                                Text("Status:")
                                    .foregroundColor(Color("fontColorMain"))
                                Spacer()
                                Text(String(orderVM.orderDetails?.orderInfo.couponStatusDesc ?? "")) .foregroundColor(Color("fontColorMain"))
                                Text("/")
                                Text(String(orderVM.orderDetails?.orderInfo.payStatusDesc ?? ""))  .foregroundColor(Color("fontColorMain"))
                            }
                            HStack {
                                                        Text("配送方式:")
                                                            .foregroundColor(Color("fontColorMain"))
                                                        Spacer()
                                                        Text(orderVM.orderDetails?.orderInfo.customerDeliveryOptionDesc ?? "")
                                                            .foregroundColor(Color("fontColorMain"))
                                                    }
                                                    HStack {
                                                        Text("配送日期:")
                                                            .foregroundColor(Color("fontColorMain"))
                                                        Spacer()
                                                        Text(orderVM.orderDetails?.orderInfo.logisticDeliveryDate ?? "")
                                                            .foregroundColor(Color("fontColorMain"))
                                                        
                                                    }
                                                    
                                                    HStack {
                                                        Text("物流说明:")
                                                            .foregroundColor(Color("fontColorMain"))
                                                        Spacer()
                                                        Text(orderVM.orderDetails?.orderInfo.deliveryDescription ?? "")
                                                            .foregroundColor(Color("fontColorMain"))
                                                            .lineLimit(10)
                                                    }

                        }
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        
                     
                        Divider()
                            .background(Color("mainBlue"))
                            .padding(.horizontal)
                        
                       
                      
                        
                        Section(header:
                            Text("Items Details")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding(.leading, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("mainBlue")).clipShape(RoundedRectangle(cornerRadius: 10)))
                        ) {
                            
                            
                            ForEach(orderVM.orderDetails!.itemsDetails, id: \.id) { item in
                                HStack(alignment: .top) {
                                    
                                    ItemImage100(imageURL: URL(string: item.menuPic ?? "thumbnails/2022-07/20220705155049490362_100x100_fill.jpg")!).padding(1)  .frame(width: 120, height: 120, alignment: .center)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(item.title)
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("fontColorMain"))
                                        Text(item.subtitle)
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("fontColorMain"))
                                     
                                     
                                            
                                            Text("Code: \(item.menuId)  \(item.guigeName ?? "")")
                                                .font(.system(size: 18))
                                                .foregroundColor(Color("fontColorMain"))
                                            
                                          
                                     
                                        
                                       
                                        
                                        Text("Quantity: \(item.num)  \(item.unitEn)")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("fontColorMain"))
                                        Text("Price: \(item.voucherDealAmount)")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color("fontColorMain"))
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        
                        Divider()
                            .background(Color("mainBlue"))
                            .padding(.horizontal)
                        
                        
                        Section(header:
                        Text("Money Detail")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("mainBlue")).clipShape(RoundedRectangle(cornerRadius: 10)))
                        ) {
                        HStack {
                        Text("Transaction Balance:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.moneyDetail.transactionBalanceNew ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        HStack {
                        Text("Delivery Fee:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.moneyDetail.deliveryFee ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        HStack {
                        Text("Promotion Total:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.moneyDetail.promotionTotal ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        HStack {
                        Text("Coupon Total:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.moneyDetail.couponTotal ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        HStack {
                        Text("Goods Total:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.moneyDetail.goodsTotal ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        }
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        
                       
                        Divider()
                            .background(Color("mainBlue"))
                            .padding(.horizontal)
                        
                        
                  
                        
                        
                        Section(header:
                        Text("Supplier Information")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.leading, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("mainBlue")).clipShape(RoundedRectangle(cornerRadius: 10)))
                        ) {
                        HStack {
                        Text("Name:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.supplierInfo.businessName ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        HStack {
                        Text("Company:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.supplierInfo.untityName ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        HStack {
                        Text("Address:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.supplierInfo.businessAddress ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        HStack {
                        Text("Business Contact Phone:")
                        .foregroundColor(Color("fontColorMain"))
                        Spacer()
                            Text(orderVM.orderDetails?.supplierInfo.businessContactPhone ?? "") .foregroundColor(Color("fontColorMain"))
                        }
                        }
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        
                        Divider()
                            .background(Color("mainBlue"))
                            .padding(.horizontal)
                        
                        
                        
                        
                        Section(header:
                            HStack {
                                Text("Log")
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .padding(.leading, 10)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("mainBlue")).clipShape(RoundedRectangle(cornerRadius: 10)))
                            .padding(.top, 10)
                        ) {
                            HStack {
                                Text("Date")
                                    .foregroundColor(Color("fontColorMain"))
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity)
                                Text("User")
                                    .foregroundColor(Color("fontColorMain"))
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity)
                                Text("Description")
                                    .foregroundColor(Color("fontColorMain"))
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 10)
                            .background(Color("backgroundCat"))
                            .padding(.bottom, 5)
                            
                            if(orderVM.orderDetails?.log  != nil) {
                                ForEach(orderVM.orderDetails!.log , id: \.genDate) { log in
                                    HStack {
                                        Text(log.genDate)
                                            .foregroundColor(Color("fontColorMain"))
                                            .frame(maxWidth: .infinity)
                                        Text(log.actionUserName)
                                            .foregroundColor(Color("fontColorMain"))
                                            .frame(maxWidth: .infinity)
                                        if let description = log.description {
                                            Text(description)
                                                .foregroundColor(Color("fontColorMain"))
                                                .font(.caption)
                                                .frame(maxWidth: .infinity)
                                        } else {
                                            Text("")
                                                .frame(maxWidth: .infinity)
                                        }
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                }
                            }
                         
                        }
                        .padding(.horizontal, 10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))

                      
                        
                        
                        
                        
                        
                        
                        Spacer()
                    }
                    .padding()
                }
                .background(Color("backgroundCat"))
                .navigationBarTitle("Order Details")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundColor(Color("grey1"))
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30.0, height: 30.0)
                        }
                    }
                }
            }
           
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear{
            
//            var _: () = orderVM.getOrderDetails(orderId: orderId, User_temp_tokens: userVM.user_temp_tokens)
        }
    }
}




struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let orderDetails = OrderDetails(
            orderInfo: OrderInfo1.sampleOrderInfo1,
            itemsDetails: ItemDetails.sampleItemDetails,
            moneyDetail: MoneyDetail.sampleMoneyDetail,
            supplierInfo: SupplierInfo.sampleSupplierInfo,
            log:Log.sampleLogs
        )
//        OrderDetailsView(orderDetails: orderDetails)
        OrderDetailsView(orderId:"orderId")
            .environmentObject(OrderViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(HomePageViewModel())
    }
}
