//
//  ResetPasswordViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 18.10.2022.
//

import Foundation

class ResetPasswordViewModel: ObservableObject {
    
    let container = DIContainer.shared.resolve(type: FirebaseAuthClient.self)
    
    @Published var email: String = ""
    @Published var forgotPassword: Bool = false
    @Published var forgotError: Bool = false
    @Published var resetOk: Bool = false
    
    func resetPassword(email: String) {
        forgotPassword = true
        
        container.resetPassword(email: email) {
        
//        authClient.resetPassword(email: email) {
            self.forgotPassword = false
        } onFailure: {
            self.forgotError = true
        }
    }
}
