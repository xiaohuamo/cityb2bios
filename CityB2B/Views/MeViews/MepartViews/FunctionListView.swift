import SwiftUI

struct FunctionListView: View {
    @Binding var showLoginView: Bool
    @EnvironmentObject var mysupplierVM:SupplierViewModel 
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("我的服务")
                .font(.headline)
                .padding(.leading,25) 
            HStack(spacing: 10) {
                FunctionUnit(image: "orderIcon", title: "订单",viewName:  AboutAppView())
                FunctionUnit(image: "vouchericon", title: "优惠券",viewName: AboutAppView())
                FunctionUnit(image: "businessmangeicon", title: "商家管理",viewName: SupplierMainView())
                Spacer()
            }.padding(.leading,25)
            Text("我的功能")
                .font(.headline)
                .padding(.leading,15)
            HStack(spacing: 10) {
                FunctionUnit(image: "qricon", title: "二维码",viewName: MyQrCodeView())
                FunctionUnit(image: "accounticon", title: "账户",viewName: AccountViews(showLoginView:$showLoginView))
                FunctionUnit(image: "security", title: "安全",viewName: SecurityMainView())
                FunctionUnit(image: "addressicon", title: "收货地址",viewName: AddressListView())
              
            }.padding(.leading,25)
            HStack(spacing: 10) {
                FunctionUnit(image: "settingicon", title: "设置",viewName: SystemSettingView())
            }.padding(.leading,25)
        }
    }
}
struct FunctionListView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionListView(showLoginView:.constant(1==1))
          
    }
}
