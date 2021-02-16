//
//  SessionView.swift
//  AWSAuthDemo
//
//  Created by Knoxpo MacBook Pro on 16/02/21.
//

import SwiftUI
import Amplify
struct SessionView: View {
    @EnvironmentObject var sessionManager: SessionManager
    let user: AuthUser
    var body: some View {
        VStack {
          Text("You are sign into amplify")
            .font(.largeTitle)
            .multilineTextAlignment(.leading)
            
            
        Spacer()
        
            Button("SignOut", action: {
                sessionManager.signOut()
            })
            
            
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    private struct DummyUser: AuthUser {
        
        let userId: String = "1"
        let username: String = "dummy"
        
    }
    
    
    static var previews: some View {
        SessionView(user: DummyUser() as AuthUser)
    }
}
