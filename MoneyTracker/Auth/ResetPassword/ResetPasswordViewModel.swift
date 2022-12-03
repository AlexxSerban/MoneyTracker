//
//  ResetPasswordViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 18.10.2022.
//

import Foundation

class ResetPasswordViewModel: ObservableObject {
    
    // User Data
    @Published var email: String = ""
    
    // Status
    @Published var isLoading: Bool = false
    @Published var forgotError: Bool = false
    
    // Navigation
    @Published var resetSuccessful: Bool = false
    
    // Dependencies
    let authClient: AuthClient
    
    init(authClient: AuthClient = DIContainer.shared.resolve(type: AuthClient.self)) {
        self.authClient = authClient
    }
    
    func resetPassword() {
        isLoading = true
        
        Task {
            do {
                let _ = try await authClient.resetPassword(email: email)
                
                await MainActor.run {
                    self.isLoading = false
                }
            } catch {
                print(error.localizedDescription)
                self.forgotError = true
            }
        }
    }
}
