//
//  FirestoreClient.swift
//  MoneyTracker
//
//  Created by Alex Serban on 29.10.2022.
//

import Foundation
import Firebase


class UserRepository: ObservableObject {
    
    let dataBase = Firestore.firestore()
    let authClient = DIContainer.shared.resolve(type: AuthClient.self)
    
    func addUser(userData: UserData) async throws {
        guard let userId = authClient.getUserId() else {
            return
        }
        try await dataBase.collection("Users").document(userId).setData(userData.dictionary)
    }
    
    func getUser() async throws -> UserData {
        guard let userId = authClient.getUserId() else {
            return UserData(name: "", phoneNumber: "", country: "")
        }
        
        let document = try await dataBase.collection("Users").document(userId).getDocument()
        
        return UserData(
            name: document.get("name") as? String ?? "",
            phoneNumber: document.get("phoneNumber") as? String ?? "",
            country: document.get("country") as? String ?? ""
        )
    } 
}
