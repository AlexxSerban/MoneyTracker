//

//  RegisterViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    var firebaseAuthClient: FirebaseAuthClient
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isRegistering: Bool = false
    @Published var isRegistered: Bool = false
    @Published var registeringError: Bool = false

    init(firebaseAuthClient: FirebaseAuthClient) {
        self.firebaseAuthClient = firebaseAuthClient
    }
    
    func register() {
        isRegistering = true
        
        firebaseAuthClient.createUser(user: email, password: password) {
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

extension RegisterViewModel {
    static let example = RegisterViewModel(firebaseAuthClient: FirebaseAuthClient())
}
