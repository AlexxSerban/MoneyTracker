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
                    id: document.documentID,
                    amount: document["amount"] as! String,
                    currency: SelectionCurrency(rawValue: document["currency"] as! String) ?? .RON,
                    category: SelectionCategory(rawValue: document["category"] as! String) ?? .Food,
                    paymentMethod: SelectionPay(rawValue: document["paymentMethod"] as! String) ?? .Card,
                    timestamp: document["date"] as! Timestamp,
                    transactionType : TransactionType(rawValue: document["transactionType"] as! String) ?? .Spend
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
                    id: document.documentID,
                    amount: document["amount"] as! String,
                    currency: SelectionCurrency(rawValue: document["currency"] as! String) ?? .RON,
                    category: SelectionCategory(rawValue: document["category"] as! String) ?? .Food,
                    paymentMethod: SelectionPay(rawValue: document["paymentMethod"] as! String) ?? .Card,
                    timestamp: document["date"] as! Timestamp,
                    transactionType : TransactionType(rawValue: document["transactionType"] as! String) ?? .Spend
                )
                
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getSpendDailyTransaction(startDate: Date, endDate: Date ) async throws -> [TransactionData] {
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("transactionType", isEqualTo: "Spend")
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return []
            } else {
                let groupedTransactions = Dictionary(grouping: querySnapshot.documents) { (document) -> Date in
                    let timestamp = document["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
                    return calendar.date(from: components)!
                }
                let transactionData = groupedTransactions.map { (key, value) -> TransactionData in
                    let amount = value.reduce(0) { (result, document) -> Int in
                        let transactionAmount = Int(document["amount"] as! String)
                        return result + (transactionAmount ?? 0)
                    }
                    return TransactionData(amount: String(amount), timestamp: Timestamp(date: key))
                }
                return transactionData
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    func getSpendWeeklyTransaction(startDate: Date, endDate: Date) async throws -> [TransactionData] {
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("transactionType", isEqualTo: "Spend")
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return []
            } else {
                let groupedTransactions = Dictionary(grouping: querySnapshot.documents) { (document) -> Date in
                    let timestamp = document["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year, .month, .day], from: date)
                    return calendar.date(from: components)!
                }
                let transactionData = groupedTransactions.map { (key, value) -> TransactionData in
                    let amount = value.reduce(0) { (result, document) -> Int in
                        let transactionAmount = Int(document["amount"] as! String)
                        return result + (transactionAmount ?? 0)
                    }
                    return TransactionData(amount: String(amount), timestamp: Timestamp(date: key))
                }
                return transactionData
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    func getSpendMonthlyTransaction(startDate: Date, endDate: Date) async throws -> [TransactionData] {
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("transactionType", isEqualTo: "Spend")
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return []
            } else {
                let groupedTransactions = Dictionary(grouping: querySnapshot.documents) { (document) -> Date in
                    let timestamp = document["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year, .month, .weekday], from: date)
                    return calendar.date(from: components)!
                }
                let transactionData = groupedTransactions.map { (key, value) -> TransactionData in
                    let amount = value.reduce(0) { (result, document) -> Int in
                        let transactionAmount = Int(document["amount"] as! String)
                        return result + (transactionAmount ?? 0)
                    }
                    return TransactionData(amount: String(amount), timestamp: Timestamp(date: key))
                }
                return transactionData
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getSpendYearTransaction(startDate: Date, endDate: Date) async throws -> [TransactionData] {
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("transactionType", isEqualTo: "Spend")
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return []
            } else{
                let groupedTransactions = Dictionary(grouping: querySnapshot.documents) { (document) -> Date in
                    let timestamp = document["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.year, .month], from: date)
                    return calendar.date(from: components)!
                }
                let transactionData = groupedTransactions.map { (key, value) -> TransactionData in
                    let amount = value.reduce(0) { (result, document) -> Int in
                        let transactionAmount = Int(document["amount"] as! String)
                        return result + (transactionAmount ?? 0)
                    }
                    return TransactionData(amount: String(amount), timestamp: Timestamp(date: key))
                }
                return transactionData
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    // Sum
    
    func calculateIncomeSum(startDate: Date, endDate: Date) async throws -> Int {
        do {
            guard let userId = authClient.getUserId() else {
                return 0
            }
            
            var sum: Int = 0
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("transactionType", isEqualTo: "Income")
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return 0
            }
            for document in querySnapshot.documents {
                if let amount = document.data()["amount"] as? String {
                    if let amountInt = Int(amount) {
                        sum += amountInt
                    }
                }
            }
            return sum
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
    
    func calculateSpendSum(startDate: Date, endDate: Date) async throws -> Int {
        do {
            guard let userId = authClient.getUserId() else {
                return 0
            }
            
            var sum: Int = 0
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("transactionType", isEqualTo: "Spend")
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return 0
            }
            for document in querySnapshot.documents {
                if let amount = document.data()["amount"] as? String {
                    if let amountInt = Int(amount) {
                        sum += amountInt
                    }
                }
            }
            return sum
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
    
    func calculateCategorySum(startDate: Date, endDate: Date, category: SelectionCategory) async throws -> Int {
        do {
            guard let userId = authClient.getUserId() else {
                return 0
            }
            
            var sum: Int = 0
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("category", isEqualTo: category.rawValue)
                .whereField("transactionType", isEqualTo: "Spend")
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                return 0
            }
            for document in querySnapshot.documents {
                if let amount = document.data()["amount"] as? String {
                    if let amountInt = Int(amount) {
                        sum += amountInt
                    }
                }
            }
            return sum
        } catch {
            print(error.localizedDescription)
            return 0
        }
    }
    
    func deleteTransactionFromFirestore(at indexSet: IndexSet, transactionData: [TransactionData]) {
        
        let validIndices = indexSet.filter { $0 < transactionData.count }
        validIndices.forEach { index in
            let transactions = transactionData[index]
            guard let userId = authClient.getUserId() else {
                return
            }
            dataBase.collection("UserData").document(userId).collection("Transactions").document("\(transactions.id)").delete { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("A mers DeleteTransacation")
                }
                
            }
        }
    }
    
}

