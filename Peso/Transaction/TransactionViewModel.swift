//
//  TransactionViewModel.swift
//  Peso
//
//  Created by Alex Serban on 19.11.2022.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    // Transaction Data
    @Published var transactionData = TransactionData()
    
    // Dependencies
    let transactionRepository: TransactionRepository
    
    init(transactionRepository: TransactionRepository = DIContainer.shared.resolve(type: TransactionRepository.self)) {
        self.transactionRepository = transactionRepository
    }
    
    func addTransactionInfo() {
        Task {
            do {
                try await transactionRepository.addTransaction(transactionData: transactionData)
                
                await MainActor.run {
                    print(" Worked addTransactionInfo")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
