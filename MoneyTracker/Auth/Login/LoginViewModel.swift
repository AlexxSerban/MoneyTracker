//
//  LoginViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 07.10.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    // User Data
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Status
    @Published var isLoading: Bool = false
    @Published var isLogged: Bool = false
    @Published var loggingError: Bool = false
    
    // Navigation
    @Published var toRegister: Bool = false
    @Published var forgotPassword: Bool = false
    
    // Dependencies
    let authClient: AuthClient

    init(authClient: AuthClient = DIContainer.shared.resolve(type: AuthClient.self)) {
        self.authClient = authClient
    }
    
    func login() {
        isLoading = true
        Task{
            do {
                let _ = try await authClient.loginUser(email: email, password: password)
                
                await MainActor.run {
                    self.isLoading = false
                    self.isLogged = true
                }
            } catch {
                print(error.localizedDescription)
                
                self.isLoading = false
                self.loggingError = true
            }
        }
    }
}
