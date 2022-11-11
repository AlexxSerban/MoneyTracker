
//  UserProfileViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 11.11.2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    let userRepository = DIContainer.shared.resolve(type: UserRepository.self)
    let authClient = DIContainer.shared.resolve(type: AuthClient.self)
    
    @Published var userData = UserData(name: "", phoneNumber: "", country: "")
    
    @MainActor
    func getData() {
        Task {
            do {
                guard let userId = authClient.getUserId() else {
                    return
                }
                
                self.userData = try await userRepository.getUser(userId: userId)
            } catch {
                print(error)
            }
        }
    }
}
