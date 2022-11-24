//
//  TransactionViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 19.11.2022.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
//    var showSheet : Bool = false
    let transactionRepository = DIContainer.shared.resolve(type: TransactionRepository.self)
    @Published var transactionData = TransactionData(amount: "", currency: TransactionData.SelectionCurrency.RON, category: TransactionData.SelectionCategory.Food, paymentMethod: TransactionData.SelectionPay.Card, date: Date())
     
    
    init(transactionData: TransactionData = TransactionData(amount: "", currency: TransactionData.SelectionCurrency.RON, category: TransactionData.SelectionCategory.Food, paymentMethod: TransactionData.SelectionPay.Card, date: Date()), showSheet: Bool) {
        self.transactionData = transactionData
//        self.showSheet = showSheet
    }
    
    func addTransactionInfo(amount: String, currency: TransactionData.SelectionCurrency, category: TransactionData.SelectionCategory, paymentMethod: TransactionData.SelectionPay, date: Date) {
        Task {
            do {
                try await transactionRepository.addTransaction(transactionData: TransactionData(amount: amount, currency: currency, category: category, paymentMethod: paymentMethod, date: date))
                await MainActor.run {
                    print("A mers addTransactionInfo")
                }
            } catch {
                print(error)
                
            }
        }
    }
}
