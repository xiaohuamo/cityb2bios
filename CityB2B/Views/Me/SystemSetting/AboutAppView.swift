//
//  AboutAppView.swift
//  CityB2B
//
//  Created by Fei Wang on 25/2/2023.
//

import SwiftUI



struct AboutAppView: View {
   
    @State private var aboutUsContent = ""
    @EnvironmentObject var user: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
           ScrollView {
               VStack(alignment: .leading, spacing: 40) {
                   if !aboutUsContent.isEmpty {
                       Text(aboutUsContent)
                           .font(.system(size: 16))
                           .foregroundColor(Color("fontColorMain"))
                           .multilineTextAlignment(.leading)
                           .padding(.horizontal, 20)
                           .padding(.top,40)
                   } else {
                       ProgressView()
                           .progressViewStyle(CircularProgressViewStyle())
                           .padding()
                   }
               }
          
           }
           .onAppear {
               fetchAboutUsContent()
           }
          
           .navigationBarTitle("关于我们", displayMode: .inline)
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

    private func fetchAboutUsContent() {
        // 通过 API 获取关于我们的内容
        // 这里仅为示例，未实际获取内容
        aboutUsContent = """
            CityB2B公司是一家一站式解决方案公司，专门为中小批发企业提供信息化的解决方案。CityB2B提供易用快捷的订货网站和手机点单APP，让用户的订货体验达到最佳。该公司为客户提供从订货网站、订单处理和发票、客户管理，到物流调度、生产和分拣，以及司机配送和结算的全方位解决方案。同时，CityB2B提供了调度及路程规划系统、智能分拣系统、发票系统、司机路程软件、入库出库、销售统计和生产系统，满足了中小型批发商的需求，帮助企业实现信息化、数字化转型，提升管理效率和运营效益。CITYB2B PLATFORM是该公司的一种解决方案，可为企业节省高达30%的人工成本，包括订单收集、订单处理、出票、生产或打包、调度、物流运输及结算等多个方面。同时，路程软件可以实现线路优化，无需手输地址，平均减少25%的时间和减少15%的公里数，车辆使用记录也清晰，如出现私用或违章，追责更容易。 CITYB2B解决方案是一种云服务，一站式服务，多重云备份方案。该公司深刻了解B2B行业的日常运营流程和存在的痛点，知道要解决那些问题和解决问题的顺序。他们会派出专业的咨询师和企业主会面，深入了解并设计由简入深的实施方案，逐步让系统与企业业务磨合，帮助企业实现运营全面信息化。
        """
    }
}

struct AboutAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutAppView()
    }
}

struct GroupBoxRowView: View{
    var name: String
    var content: String
    var linkLabel: String? = nil
    
    var body: some View{
        HStack{
            Text(name)
                .foregroundColor(.gray)
                .padding()
            Spacer()
            if linkLabel != nil{
                Link(content, destination: URL(string: "https://\(linkLabel!)")!)
                    .padding()
                
            }else {
                Text(content)
                    .padding()
            }
        }
    }
}

