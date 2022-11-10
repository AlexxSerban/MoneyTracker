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
    
    
    
    func addUser(userData: UserData) async throws -> Void {
        try await dataBase.collection("Users").document(authClient.getUserId()).setData(userData.dictionary)
    }
 
    
    func getUser(userData: UserData) async throws -> DocumentSnapshot {
        return try await dataBase.collection("Users").document(authClient.getUserId()).getDocument()
    }
}
