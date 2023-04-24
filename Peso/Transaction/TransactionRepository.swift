//
//  TransactionRepository.swift
//  Peso
//
//  Created by Alex Serban on 19.11.2022.
//

import Foundation
import Firebase
import FirebaseFirestore


class TransactionRepository: ObservableObject {
    
    let dataBase: Firestore
    let authClient: AuthClient
    
    init(authClient: AuthClient = DIContainer.shared.resolve(type: AuthClient.self)) {
        self.dataBase = Firestore.firestore()
        self.authClient = authClient
        
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        
        // Enable offline data persistence
        self.dataBase.settings = settings
    }
    
    func addTransaction(transactionData: TransactionData) async throws {
        
        guard let userId = authClient.getUserId() else {
            return
        }
        try await dataBase.collection("UserData").document(userId).collection("Transactions").document().setData(transactionData.dictionary)
        
    }
    
    func getTransactions(transactionNumber: Int = 5, currency: SelectionCurrency) async throws-> [TransactionData] {
        
        do {
            
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("currency", isEqualTo: "\(currency)")
                .limit(to: transactionNumber).getDocuments()
            
            return querySnapshot.documents.map { document in
                
                TransactionData(
                    id: document.documentID,
                    amount: document["amount"] as! String,
                    currency: SelectionCurrency(rawValue: document["currency"] as! String) ?? .RON,
                    category: SelectionCategory(rawValue: document["category"] as! String) ?? .Food,
                    timestamp: document["date"] as! Timestamp,
                    transactionType : TransactionType(rawValue: document["transactionType"] as! String) ?? .Spend
                )
                
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getFilteredTransaction(startDate: Date, endDate: Date, currency: SelectionCurrency) async throws -> [TransactionData] {
        
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("currency", isEqualTo: "\(currency)")
                .getDocuments()
            
            return querySnapshot.documents.map { document in
                
                TransactionData(
                    id: document.documentID,
                    amount: document["amount"] as! String,
                    currency: SelectionCurrency(rawValue: document["currency"] as! String) ?? .RON,
                    category: SelectionCategory(rawValue: document["category"] as! String) ?? .Food,
                    timestamp: document["date"] as! Timestamp,
                    transactionType : TransactionType(rawValue: document["transactionType"] as! String) ?? .Spend
                )
                
            }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    
    func getSpendTransactions(periodSection: PeriodSection, startDate: Date, endDate: Date, currency: SelectionCurrency) async throws -> [TransactionData] {
        
        do {
            guard let userId = authClient.getUserId() else {
                return []
            }
            
            var dateComponentsValues: Set<Calendar.Component> = []
            
            switch periodSection {
            case .day:
                dateComponentsValues = [.year, .month, .day, .hour]
                
            case .week:
                dateComponentsValues = [.year, .month, .day]
                
            case .month:
                dateComponentsValues = [.year, .month, .weekday]
                
            case .year:
                dateComponentsValues = [.year, .month]
            }
            
            let querySnapshot = try await dataBase.collection("UserData").document(userId).collection("Transactions")
                .order(by: "date", descending: true)
                .whereField("date", isGreaterThanOrEqualTo: startDate)
                .whereField("date", isLessThanOrEqualTo: endDate)
                .whereField("transactionType", isEqualTo: "Spend")
                .whereField("currency", isEqualTo: "\(currency)")
                .getDocuments()
            
            if querySnapshot.documents.isEmpty {
                
                return []
                
            } else {
                
                let groupedTransactions = Dictionary(grouping: querySnapshot.documents) { (document) -> Date in
                    let timestamp = document["date"] as! Timestamp
                    let date = timestamp.dateValue()
                    let calendar = Calendar.current
                    let components = calendar.dateComponents(dateComponentsValues, from: date)
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
    
    func calculateIncomeSum(startDate: Date, endDate: Date, currency: SelectionCurrency) async throws -> Int {
        
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
                .whereField("currency", isEqualTo: "\(currency)")
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
    
    func calculateSpendSum(startDate: Date, endDate: Date, currency: SelectionCurrency) async throws -> Int {
        
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
                .whereField("currency", isEqualTo: "\(currency)")
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
    
    func calculateCategorySum(startDate: Date, endDate: Date, category: SelectionCategory, currency: SelectionCurrency) async throws -> Int {
        
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
                .whereField("currency", isEqualTo: "\(currency)")
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
            guard let userId = authClient.getUserId() else { return }
            
            let transactions = transactionData[index]
            
            dataBase.collection("UserData").document(userId).collection("Transactions").document("\(transactions.id)").delete { error in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Worked DeleteTransacation")
                }
                
            }
        }
    }
}

