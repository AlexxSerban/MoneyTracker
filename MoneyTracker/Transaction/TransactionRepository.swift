//
//  TransactionRepository.swift
//  MoneyTracker
//
//  Created by Alex Serban on 19.11.2022.
//

import Foundation
import Firebase


class TransactionRepository: ObservableObject {
    
    let dataBase: Firestore
    let authClient: AuthClient
    
    init(dataBase: Firestore = Firestore.firestore(), authClient: AuthClient = DIContainer.shared.resolve(type: AuthClient.self)) {
        self.dataBase = dataBase
        self.authClient = authClient
    }
    
    func addTransaction(transactionData: TransactionData) async throws {
        guard let userId = authClient.getUserId() else {
            return
        }
        
        try await dataBase.collection("UserData").document(userId).collection("Transactions").document().setData(transactionData.dictionary)
    }
}
