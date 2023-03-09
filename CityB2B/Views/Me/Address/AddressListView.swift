import SwiftUI

struct AddressListView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var isActive = false
    var body: some View {
        VStack{
            
            NavigationLink(destination:  AddressEditView(address: Address.sampleAddress)    , isActive: $isActive) {
                                EmptyView()
                            }
            
            if (user.addressList != nil) {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(user.addressList!, id: \.id) { address1 in
                            AddressListItemView(address: address1, isSelected: (address1.is_default_address != 0) , didSelectAddress: { selectedAddress in
                                user.addressList
                            })
                        }
                    }
                }
                .background(Color.white)
            }
            Spacer() // 添加一个 Spacer 视图，以使按钮位于底部
                      // 在 VStack 的外面添加一个 Button 视图
            Button(action: {
                
                self.isActive = true
                // 点击按钮时的操作
                // 这里我们可以使用 NavigationLink 进行页面跳转
               
               
            }) {
                HStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("mainBlue"))
                    Text("添加地址")
                        .foregroundColor(Color("mainBlue"))
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("mainBlue"), lineWidth: 1)
            )
            

            .padding(.bottom, 16)
                  }.onAppear{
//            获得地址列表
            self.user.getAddressList(User_temp_tokens: user.user_temp_tokens)
        }
       
        .navigationBarTitle("地址列表")
         .navigationBarTitleDisplayMode(.inline)
//        @Environment(\.presentationMode) var presentationMode
         .navigationBarBackButtonHidden()
         .navigationBarItems(leading: Button(action: {
                             self.presentationMode.wrappedValue.dismiss()
                         }) {
                             HStack {
                                 Image(systemName: "chevron.left") .foregroundColor(Color("fontColorMain"))
                                 Text("")
                             }
                         })
        
    }
    
   
}

struct AddressListItemView: View {
    let address: Address
    let isSelected: Bool
    let didSelectAddress: (Address) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 16) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(isSelected ? Color("mainBlue") : .gray)
                VStack(alignment: .leading, spacing: 4) {
                    NavigationLink(destination:  AddressEditView(address: address),  label: {
                        VStack{
                            Text(address.address)
                                .font(.headline)
                                .foregroundColor(.black)
                                .lineLimit(2)
                                .frame(alignment: .leading)
                               
                  
                            Text("\(address.display_name)  ·  \(address.phone)")
                                .foregroundColor(.gray)
                    }
                     
                       
                    })
                   
                }
                Spacer()
                NavigationLink(destination: AddressEditView(address: address)) {
                    Image("editicon")
                        .foregroundColor(Color("mainBlue"))
                        .frame(width: 30,height: 30)
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(10)
            .onTapGesture {
                didSelectAddress(address)
            }
            Divider()
        }
    }
    
}

struct AddressListView_Previews: PreviewProvider {
    static var previews: some View {
        
        AddressListItemView(address: Address.sampleAddress, isSelected: (1 != 0), didSelectAddress: { selectedAddress in
            // 在这里处理选择地址的逻辑
            print("选择的地址是：\(selectedAddress)")
        }).environmentObject(UserViewModel())

    }
    
    
}

