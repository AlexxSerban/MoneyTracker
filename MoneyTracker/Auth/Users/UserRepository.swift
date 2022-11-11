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
    
    enum UserRepositoryError: Error{
        case missingUserId(String)
    }
    
    func addUser(userData: UserData) async throws -> Void {
        guard let userId = authClient.getUserId() else {
            return
        }
        
        try await dataBase.collection("Users").document(userId).setData(userData.dictionary)
    }
    
    func getUser(userData: UserData) async throws -> DocumentSnapshot {
        guard let userId = authClient.getUserId() else {
            throw UserRepositoryError.missingUserId("Missing user id")
        }
        
        return try await dataBase.collection("Users").document(userId).getDocument()
    }
}
