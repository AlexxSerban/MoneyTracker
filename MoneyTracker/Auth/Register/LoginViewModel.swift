//
//  LoginViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 07.10.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    var loginAuthClient: FirebaseAuthClient
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLogging: Bool = false
    @Published var isLogged: Bool = false
    @Published var loggingError: Bool = false

    init(loginAuthClient: FirebaseAuthClient) {
        self.loginAuthClient = loginAuthClient
    }
    
    func login() {
        isLogging = true
        
        loginAuthClient.loginUser(user: email, password: password) {
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

extension LoginViewModel {
    static let example = LoginViewModel(loginAuthClient: FirebaseAuthClient())
}
