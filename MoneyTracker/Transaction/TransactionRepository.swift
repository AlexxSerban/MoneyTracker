//
//  TransactionRepository.swift
//  MoneyTracker
//
//  Created by Alex Serban on 19.11.2022.
//

import Foundation
import Firebase


class TransactionRepository: ObservableObject {
    
    let dataBase = Firestore.firestore()
    let authClient = DIContainer.shared.resolve(type: AuthClient.self)
    var date = Date.now
    
    
    func addTransaction(transactionData: TransactionData) async throws {
        guard let userId = authClient.getUserId() else {
            return
        }
        
        try await dataBase.collection("UserData").document(userId).collection("Transactions").document().setData(transactionData.dictionary)
    }
    
}
