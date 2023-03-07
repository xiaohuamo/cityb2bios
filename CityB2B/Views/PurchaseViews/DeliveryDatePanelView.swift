//
//  DeliveryDatePanelView.swift
//  CityB2B
//
//  Created by Fei Wang on 9/2/2023.
//

import SwiftUI

struct DeliveryDatePanelView: View {
    
    @Environment (\.presentationMode) var presentationMode
    
    //    @Binding var y: String currentDeliveryOptionValue
    @EnvironmentObject var deliveryDateVM: DeliveryDateViewModel
    @State private var selection: DeliveryDate?
    @State private var selection1: DeliveryDate?
    @State private var displayWidth: CGFloat = 0
    @State private var displayHeight: CGFloat = 0
    @State private var widthAndHeight = ""
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DeliveryDatePanelView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryDatePanelView()
    }
}
