//

//  RegisterViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation

class RegisterViewModel: ObservableObject {
    
    let authClient = DIContainer.shared.resolve(type: AuthClient.self)
    

    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isRegistering: Bool = false
    @Published var isRegistered: Bool = false
    @Published var registeringError: Bool = false
    
    func register() {
        self.isRegistering = true
        
        Task {
            do {
                let authResult = try await authClient.createUser(email: email, password: password)
                
                await MainActor.run {
                    self.isRegistering = false
                    self.isRegistered = true
                }
            } catch {
                print(error)
                
                await MainActor.run {
                    self.isRegistering = false
                    self.registeringError = true
                }
            }
        }
    }
    
}


