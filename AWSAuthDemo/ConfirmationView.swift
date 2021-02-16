//
//  ConfirmationView.swift
//  AWSAuthDemo
//
//  Created by Knoxpo MacBook Pro on 16/02/21.
//

import SwiftUI

struct ConfirmationView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State var confirmationcode = ""
    let userName: String
    var body: some View {
        
        VStack {
            Text("UserName\(userName)")
            TextField("Confirmed code",text: $confirmationcode)
            
            Button("CONFIRM", action: {
                
                sessionManager.confirm(username: userName, code: confirmationcode)
                
                
            })
    
            
        }
        .padding()
        
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(userName: "ash")
    }
}
