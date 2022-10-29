//
//  LoginViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 07.10.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    let container = DIContainer.shared.resolve(type: FirebaseAuthClient.self)
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLogging: Bool = false
    @Published var isLogged: Bool = false
    @Published var loggingError: Bool = false
    
    
    
    func login() {
        isLogging = true
        
        container.loginUser(user: email, password: password) {
        
//        authClient.loginUser(user: email, password: password) {
            //onSuccess
            self.isLogging = false
            self.isLogged = true
        } onFailure: {
            //onFailure
            self.isLogging = false
            self.loggingError = true
        }
    }
    
   
}

