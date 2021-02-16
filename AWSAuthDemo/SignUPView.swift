//
//  SignUPView.swift
//  AWSAuthDemo
//
//  Created by Knoxpo MacBook Pro on 16/02/21.
//

import SwiftUI

struct SignUPView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var UserName =  ""
    @State var  Email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack
        {
            Spacer()
            TextField("UserName", text: $UserName)
            TextField("Email", text: $Email)
            SecureField("Password",text: $password)
            Button("Sign UP", action: {
                sessionManager.showSignUp()
                
                
                
                
            })
            
            Spacer()
            Button("Youb are already login", action:
                sessionManager.showLogin)
            
        }
        
        
        
        
    }
}

struct SignUPView_Previews: PreviewProvider {
    static var previews: some View {
        SignUPView()
    }
}
