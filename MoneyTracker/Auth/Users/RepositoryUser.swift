//
//  FirestoreClient.swift
//  MoneyTracker
//
//  Created by Alex Serban on 29.10.2022.
//

import Foundation
import Firebase


class RepositoryUser {
    
    let dataBase = Firestore.firestore()
    
    func addData(userData: UserData) async throws -> Void {
        try await dataBase.collection("Users").document(userData.email).setData(userData.dictionary)
    }
 
    
    func getData(userData: UserData) async throws -> DocumentSnapshot {
        return try await dataBase.collection("Users").document(userData.email).getDocument()
    }
}
