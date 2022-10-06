//

//  SignUpViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation

class SignUpViewModel: ObservableObject {
    var firebaseAuthClient: FirebaseAuthClient
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isSigningUp: Bool = false
    @Published var isSignedUp: Bool = false
    @Published var signingError: Bool = false

    init(firebaseAuthClient: FirebaseAuthClient) {
        self.firebaseAuthClient = firebaseAuthClient
    }
    
    func signUp() {
        isSigningUp = true
        
        firebaseAuthClient.createUser(user: email, password: password) {
            //onSuccess
            self.isSigningUp = false
            self.isSignedUp = true
        } onFailure: {
            //onFailure
            self.isSigningUp = false
            self.signingError = true
        }
    }
}
