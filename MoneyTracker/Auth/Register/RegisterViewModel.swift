//

//  RegisterViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    var authClient = AppDependencyContainer.shared.firebaseAuthClient
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isRegistering: Bool = false
    @Published var isRegistered: Bool = false
    @Published var registeringError: Bool = false
    
    
    func register() {
        isRegistering = true
        
        authClient.createUser(user: email, password: password) {
            //onSuccess
            self.isRegistering = false
            self.isRegistered = true
        } onFailure: {
            //onFailure
            self.isRegistering = false
            self.registeringError = true
        }
    }
}


