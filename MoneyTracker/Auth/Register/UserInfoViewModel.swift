//
//  UserInfoViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 10.11.2022.
//

import Foundation

class UserInfoViewModel: ObservableObject {
    
    let userRepository = DIContainer.shared.resolve(type: UserRepository.self)
    let userData = UserData(name: "", phoneNumber: "", country: "")
    
    func addInfoProfile(name: String, phoneNumber: String, country: String) {
        Task {
            do {
                try await userRepository.addUser(userData: UserData(name: name, phoneNumber: phoneNumber, country: country))
                await MainActor.run {
                    print("All good")
                }
            } catch {
                print(error)
                
            }
        }
    }
}


