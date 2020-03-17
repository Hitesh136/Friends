//
//  LoginView.swift
//  Friends
//
//  Created by Hitesh Agarwal on 22/01/20.
//  Copyright © 2020 Hitesh  Agarwal. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var username: String = "text1@gmail.com"
    @State var password: String = "dummy@123"
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Welcome to iFriends")
                .font(.system(size: 25))
                .fontWeight(.bold)
                .padding(.top, 40)
                .lineLimit(1)
                .padding(.leading, 0)
                .alignmentGuide(.leading) { d in d[.center] }
                
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 30)
            
            TextField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 15)
            
            
            Spacer()
        }
        .padding([.trailing, .leading], 20)
            
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
