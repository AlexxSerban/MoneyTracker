//

//  RegisterViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    // User Data
    @Published var email: String = ""
    @Published var password: String = ""
    
    // Status
    @Published var isLoading: Bool = false
    @Published var isRegistered: Bool = false
    @Published var registeringError: Bool = false
    
    // Navigation
    @Published var toLogin: Bool = false
    
    // Dependencies
    let authClient: AuthClient
    
    init(authClient: AuthClient = DIContainer.shared.resolve(type: AuthClient.self)) {
        self.authClient = authClient
    }
    
    func register() {
        self.isLoading = true
        
        Task {
            do {
                let _ = try await authClient.createUser(email: email, password: password)
                
                await MainActor.run {
                    self.isLoading = false
                    self.isRegistered = true
                }
            } catch {
                print(error.localizedDescription)
                
                await MainActor.run {
                    self.isLoading = false
                    self.registeringError = true
                }
            }
        }
    }
    
}


