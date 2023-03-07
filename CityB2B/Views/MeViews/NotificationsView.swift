//
//  NotificationsView.swift
//  CityB2B
//
//  Created by Fei Wang on 25/2/2023.
//

import SwiftUI


struct NotificationsView: View{
        
    @State var recommendtaionToggleIsActive: Bool = false
    @State var orderToggleIsActive: Bool = false
    
    var body: some View{
        VStack{
            Toggle(
                isOn: $recommendtaionToggleIsActive,
                label: {
                    Text("推荐")
                })
            .toggleStyle(SwitchToggleStyle(tint: .green))
            .padding()
            .background(
                Color(.gray)
                    .opacity(0.25)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            )
            .padding()
            
            Toggle(
                isOn: $orderToggleIsActive,
                label: {
                    Text("订单留言")
                })
            .toggleStyle(SwitchToggleStyle(tint: .green))
            .padding()
            .background(
                Color(.gray)
                    .opacity(0.25)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            )
            .padding()
        }
        Spacer()
        
    }
    
}


struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
