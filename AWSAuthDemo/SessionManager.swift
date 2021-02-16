//
//  SessionManager.swift
//  AWSAuthDemo
//
//  Created by Knoxpo MacBook Pro on 16/02/21.
//

import Foundation
import Amplify

enum AuthState {
    
case signUp
    
 case login
    
    case confirmCode(userName: String)
    case session(user: AuthUser)
    
}

final class SessionManager: ObservableObject {
    
    @Published var authState: AuthState = .login
    func getCurentAuthUser() {
        if let user = Amplify.Auth.getCurrentUser()
        {
            authState = .session(user: user)
            
        }
        else{
            
            authState = .login
        }
        
        
        
    }
    
    func showSignUp() {
        authState = .signUp
        
    }
    
    func showLogin() {
        authState = .login
        
    }
    
    func signUp(userName: String, email: String, password: String)
    {
        let attribute = [AuthUserAttribute(.email, value: email)]
        let option = AuthSignUpRequest.Options(userAttributes: attribute)
        _ = Amplify.Auth.signUp(username: userName, password: password, options: option) { result in
            
            switch result {
                
                case .success(let signUpResult):
                print("result iss",signUpResult)
                    switch signUpResult.nextStep {
                    case .done:
                        print()
                        
                    case .confirmUser(let details, _):
                    print(details ?? "no details")
                        
                        DispatchQueue.main.async {
                            self.authState = .confirmCode(userName: userName)
                        }
                    
                    }
                    
                
            case .failure(let error):
                print("signUP error",error)
                
            }
            
            
            
            
        }
        
        
        
    }
    
    func confirm(username: String, code:String) {
        
        _ = Amplify.Auth.confirmSignUp(for: username,confirmationCode: code ) { [weak self] result in
            switch result {
            
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete {
                    DispatchQueue.main.async {
                        self?.showLogin()
                    }
                    
                }
                
            case .failure(let error):
                print(error)
            
            
            }
            
            
        }
     
        
    }
    
    func login(username: String, password: String)
    {
        
        _ = Amplify.Auth.signIn(username: username, password: password) { [weak self] result in
            
            switch result {
            
            case .success(let signINResult):
            
            print(signINResult)
                
                if signINResult.isSignedIn {
                    
                    DispatchQueue.main.async {
                        self?.getCurentAuthUser()
                    }
                }
            case .failure(let error):
                print("Logoin error", error)
            
            }
            
            
            
            
            
            
        }
        
        
        
    }
    
    func signOut()
    {
        _ = Amplify.Auth.signOut { [weak self] result in
            
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.getCurentAuthUser()
                }
            
            case .failure(let error):
                print(error)
            
            
            
            
            }
            
            
            
        }
        
        
    }
    
    
    
    
}
