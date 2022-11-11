//
//  ResetPasswordViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 18.10.2022.
//

import Foundation

class ResetPasswordViewModel: ObservableObject {
    
    let authClient = DIContainer.shared.resolve(type: AuthClient.self)
    
    @Published var email: String = ""
    @Published var forgotPassword: Bool = false
    @Published var forgotError: Bool = false
    @Published var resetOk: Bool = false
    
    func resetPassword() {
        forgotPassword = true
        
        Task {
            do {
                let resetResult = try await authClient.resetPassword(email: email)
                
                await MainActor.run {
                    self.forgotPassword = false
                }
            } catch {
                print(error)
                self.forgotError = true
            }
        }
    }
}
