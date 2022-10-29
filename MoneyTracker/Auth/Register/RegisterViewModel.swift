//

//  RegisterViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    let container = DIContainer.shared.resolve(type: FirebaseAuthClient.self)
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isRegistering: Bool = false
    @Published var isRegistered: Bool = false
    @Published var registeringError: Bool = false
    
    func register() {
        isRegistering = true
        
        container.createUser(user: email, password: password) {
        
//        authClient.createUser(user: email, password: password) {
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


