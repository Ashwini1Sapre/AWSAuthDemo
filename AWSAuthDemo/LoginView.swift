//
//  LoginView.swift
//  AWSAuthDemo
//
//  Created by Knoxpo MacBook Pro on 16/02/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var UserName = ""
    @State var password = ""
    
    
    var body: some View {
        VStack {
            
            Spacer()
            
            TextField("UserName",text: $UserName)
            SecureField("Password",text: $password)
            Button("Login", action: {
                sessionManager.login(username: UserName, password: password)
                
                
            })
            
            Spacer()
            Button("Dont have account tjen SignUP", action:
                sessionManager.showSignUp
            )
            
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
