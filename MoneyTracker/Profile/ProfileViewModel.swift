
//  UserProfileViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 11.11.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    // Dependencies
    let authClient: AuthClient
    let userRepository: UserRepository
    
    init(
        authClient: AuthClient = DIContainer.shared.resolve(type: AuthClient.self),
        userRepository: UserRepository = DIContainer.shared.resolve(type: UserRepository.self)
    ) {
        self.authClient = authClient
        self.userRepository = userRepository
    }

    func signOutUser() {
        Task{
            do {
                let _ = try await authClient.signOut()
                
            } catch {
                print(error.localizedDescription)
                
            }
        }
    }
    
    func deleteUser() {
        Task{
            do {
                let _ = try await authClient.deleteAccount()
                
            } catch {
                print(error.localizedDescription)
                
            }
        }
    }
}


