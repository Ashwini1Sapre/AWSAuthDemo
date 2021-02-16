//
//  AuthenticatedApp.swift
//  Authenticated
//
//  Created by Kyle Lee on 7/21/20.
//

import Amplify
import AmplifyPlugins
import SwiftUI

@main
struct AuthenticatedApp: App {
    
    @ObservedObject var sessionManager = SessionManager()
    
    init() {
        configureAmplify()
       // sessionManager.getCurentAuthUser()
    }
    
    var body: some Scene {
        WindowGroup {
            switch sessionManager.authState {
            case .login:
                LoginView()
                    .environmentObject(sessionManager)
                
            case .signUp:
                SignUPView()
                    .environmentObject(sessionManager)
                
            case .confirmCode(let username):
                ConfirmationView(userName: username)
                    .environmentObject(sessionManager)
                
            case .session(let user):
                SessionView(user: user)
                    .environmentObject(sessionManager)
            }
        }
    }
    
    private func configureAmplify() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
}
