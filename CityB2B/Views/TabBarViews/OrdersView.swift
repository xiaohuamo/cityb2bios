
import SwiftUI

struct OrdersView: View{
    
    @EnvironmentObject var orderVM: OrderViewModel
    @EnvironmentObject var homePageVM: HomePageViewModel
    @EnvironmentObject var userVM: UserViewModel
    @State private var searchText: String = ""
    
    @State private var startDate = Date()-7*24*60*60
    @State private var endDate = Date()
    @State private var endSelectDate = Date()+14*24*60*60
    @State private var calendarId: Int = 0
  
    
    @Environment(\.dismiss) var dismiss
    @State private var isShowSupplierList = false
    //    var message : CurrentUserFactorys
//    var supplier_id : String = ""
    var body: some View{
      
        NavigationView{
        VStack{
            ZStack{
                Rectangle()
                    .fill(Color("mainBlue"))
                    .cornerRadius(6)
                    .frame(width: .infinity,height:90)
                    .padding(.top,90)
                    .padding(0)
                    
                
                VStack{
                    HStack{
                        if(orderVM.supplier_name != "") {
                            Text("\(orderVM.supplier_name)")
                                .foregroundColor(Color.white)
                                .font(.system(size:18))
                                .padding(.leading,15 )
                        }else{
                            Text("选择供应商")
                                .foregroundColor(Color.white)
                                .font(.system(size:18))
                                .padding(.leading,15 )
                        }
                       
                          
                          
                         Spacer()
                        Image("arrow_right").padding(.trailing,15)
                    }.padding(.top,70)
                     .onTapGesture {
                            isShowSupplierList = true
                     }.sheet(isPresented: $isShowSupplierList ){
                         ChooseSupplierOfUserView()
                             .presentationDetents([.height(200)] )

                     }
                       
                        
                    HStack{
                        DatePicker(selection: $startDate, in: ...endSelectDate, displayedComponents: .date){
                                        Text("Select a date")
                        }.labelsHidden()
                            .accentColor(Color("mainBlue"))
                            .colorInvert()
                                  .colorMultiply(Color.white)
                                  
                            .padding(.leading,5)
                            
                            .id(calendarId)
                            .onChange(of: startDate) { _ in
                                print("\(startDate)")
                                calendarId += 1
                                self.getOrders()
                                
                                
                                
                            }
                          Image("arrow_down").padding(.trailing,15)
                        Spacer()
                        DatePicker(selection: $endDate, in: ...endSelectDate , displayedComponents: .date){
                                        Text("Select a date")
                        }.labelsHidden()
                            .accentColor(Color("mainBlue"))
                            .colorInvert()
                                  .colorMultiply(Color.white)
                                  
                            .padding(.leading,5)
                            .id(calendarId)
                            .onChange(of: endDate) { _ in
                                print("\(endDate)")
                                calendarId += 1
                                self.getOrders()
                                
                            }
                        Image("arrow_down").padding(.trailing,15)
                           
                            
                    }
                   
                }.padding(.top,20)
                
                
                
            }
            if self.orderVM.orderList != nil{
               
              
                ScrollView{
                    /*
                     DetailedOrderView(order: self.orderVM.orderList![index])
                     */
                    ForEach(0..<self.orderVM.orderList!.count, id: \.self){ index in
                        
              
                        NavigationLink(destination: OrderDetailsView(orderId: self.orderVM.orderList![index].orderId)) {
                            OrderSearchCell(order: self.orderVM.orderList![index])}
                          
                    }
                    Spacer()
                }
                
            }
            else{
                Text("目前还没有订单")
            }
        }.padding()
                .navigationBarTitle("CityB2B")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(leading: LeadingBarItem(), trailing: TrailingBarItem())
            .onAppear{
                
              self.getOrders()
                
              

                
               
                
            }.ignoresSafeArea()
            .background(Color("backgroundCat"))
         }
    }
    
    func getOrders() {
        var startDate1 = startDate.formatted(date: .numeric, time: .omitted)
        var endDate1 = endDate.formatted(date: .numeric, time: .omitted)
      
        orderVM.searchStartDate = startDate1
        orderVM.searchEndDate = endDate1
        
        
        orderVM.getUserOrders(factoryId:self.orderVM.supplier_id,start_time: orderVM.searchStartDate,end_time: orderVM.searchEndDate, User_temp_tokens :    userVM.user_temp_tokens)
        
    }
}



struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView().environmentObject(OrderViewModel())
            .environmentObject(UserViewModel())
            .environmentObject(HomePageViewModel())
    }
}
