//
//  AboutAppView.swift
//  CityB2B
//
//  Created by Fei Wang on 25/2/2023.
//

import SwiftUI


struct AboutAppView: View{
        
    @EnvironmentObject var user: UserViewModel
    
    var body: some View{
        
        VStack{
            GroupBoxRowView(name: "Developer", content: "Michał Babicz")
            Divider()
            GroupBoxRowView(name: "Source Code", content: "GitHub", linkLabel: "github.com/mbabicz/MovieCat")
            Divider()
            GroupBoxRowView(name: "Compatibility", content: "iOS 16+")
            Divider()
            GroupBoxRowView(name: "Version", content: "1.0")
            Divider()

        }
        Spacer()

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

