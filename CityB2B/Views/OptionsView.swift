//
//  NormalExample.swift
//  PartialSheetExample
//
//  Created by Andrea Miotto on 29/4/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI
import PartialSheet
//创建学生对象
struct StudentModel:Identifiable ,Hashable {
    let id = UUID() //学生id
    let idd:String //学生姓名
    let name:String //学生姓名
    let age:String  //学生年龄
    let avatar:String
}





struct OptionsView: View {
    @State private var isSheetPresented = false

    var body: some View {
        HStack {
            Spacer()
            PSButton(
                isPresenting: $isSheetPresented,
                label: {
                    Text("Display the Partial Sheet")
                })
                .padding()
            Spacer()
        }
        .partialSheet(isPresented: $isSheetPresented,
                      content: DeliveryOPtionView.init)
        .navigationBarTitle("Delivery Option")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            OptionsView()
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


