//
//  FunctionUnit.swift
//  CityB2B
//
//  Created by Fei Wang on 25/2/2023.
//
import SwiftUI
import Foundation
struct FunctionUnit<Destination: View>: View {
    let image: String
    let title: String
    let viewName: Destination

    var body: some View {
        VStack {
            NavigationLink(destination: viewName) {
                VStack {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle(title)
            .navigationBarItems(leading: Text(""), trailing: Text(""))
        }
        .frame(width: 90, height: 110)
        .background(Color.white)
        .cornerRadius(10)
    }
}
