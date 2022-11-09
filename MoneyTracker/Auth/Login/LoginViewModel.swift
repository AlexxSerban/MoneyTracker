//
//  LoginViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 07.10.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    let authClient = DIContainer.shared.resolve(type: AuthClient.self)
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogging: Bool = false
    @Published var isLogged: Bool = false
    @Published var loggingError: Bool = false

    
    func login() {
        isLogging = true
        
        Task{
            do {
                let authResult = try await authClient.loginUser(email: email, password: password)
                
                await MainActor.run {
                    
                    self.isLogging = false
                    self.isLogged = true
                }
            } catch {
                print(error)
                
                self.isLogging = false
                self.loggingError = true
            }
        }
    }
}

