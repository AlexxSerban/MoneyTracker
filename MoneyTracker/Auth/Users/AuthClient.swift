//
// AuthClient.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation
import Firebase

class AuthClient {
    
    func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func loginUser(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func resetPassword(email: String) async throws {
         try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}
