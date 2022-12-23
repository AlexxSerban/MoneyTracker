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
    
    func getTransactions(transactionNumber: Int = 5) async throws-> [TransactionData] {
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .limit(to: transactionNumber).getDocuments()
            
            
            return querySnapshot.documents.map { document in
                TransactionData(
                    amount: document["amount"] as! String,
                    currency: SelectionCurrency(rawValue: document["currency"] as! String) ?? .RON,
                    category: SelectionCategory(rawValue: document["category"] as! String) ?? .Food,
                    paymentMethod: SelectionPay(rawValue: document["paymentMethod"] as! String) ?? .Card,
                    timestamp: document["date"] as! Timestamp
                )
            }
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getFilteredTransaction(startDate: Date, endDate: Date) async throws -> [TransactionData] {
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .getDocuments()
            
            return querySnapshot.documents.map { document in
                TransactionData(
                    amount: document["amount"] as! String,
                    currency: SelectionCurrency(rawValue: document["currency"] as! String) ?? .RON,
                    category: SelectionCategory(rawValue: document["category"] as! String) ?? .Food,
                    paymentMethod: SelectionPay(rawValue: document["paymentMethod"] as! String) ?? .Card,
                    timestamp: document["date"] as! Timestamp
                )
            }
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    
    
    
    
    
    
    
    
    //    func getAllTransactions() async throws-> [TransactionData] {
    //        do {
    //            guard let userId = authClient.getUserId() else {
    //                return []
    //            }
    //
    //
    //            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions").order(by: "date", descending: true).getDocuments()
    //
    //
    //            return querySnapshot.documents.map { document in
    //                TransactionData(
    //                    amount: document["amount"] as! String,
    //                    currency: SelectionCurrency(rawValue: document["currency"] as! String) ?? .RON,
    //                    category: SelectionCategory(rawValue: document["category"] as! String) ?? .Food,
    //                    paymentMethod: SelectionPay(rawValue: document["paymentMethod"] as! String) ?? .Card,
    //                    timestamp: document["date"] as! Timestamp
    //                )
    //            }
    //
    //        } catch {
    //            print(error.localizedDescription)
    //            return []
    //        }
    //    }
}

