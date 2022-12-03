
//  UserProfileViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 11.11.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var userData = UserData()
    
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
    
    @MainActor
    func getData() {
        Task {
            do {
                guard let userId = authClient.getUserId() else {
                    return
                }
                
                self.userData = try await userRepository.getUser(userId: userId)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
