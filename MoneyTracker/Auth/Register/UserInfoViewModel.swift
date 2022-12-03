//
//  UserInfoViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 10.11.2022.
//

import Foundation

class UserInfoViewModel: ObservableObject {
    
    // User Data
    @Published var userData = UserData()
    
    // Status
    @Published var isSuccessful: Bool = false
    
    // Dependencies
    let userRepository: UserRepository
    
    init(userRepository: UserRepository = DIContainer.shared.resolve(type: UserRepository.self)) {
        self.userRepository = userRepository
    }
    
    func addProfileInfo() {
        Task {
            do {
                try await userRepository.addUser(userData: userData)
                
                await MainActor.run {
                    print("All good")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


