//
//  HomeViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 03.12.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    // Transaction Data
    @Published var transactionData = [TransactionData()]
    
    // Dependencies
    let transactionRepository: TransactionRepository
    
    init(transactionRepository: TransactionRepository = DIContainer.shared.resolve(type: TransactionRepository.self)) {
        self.transactionRepository = transactionRepository
    }
    
    @MainActor
    func getLastTransactions() {
        Task{
            do {
                self.transactionData = try await transactionRepository.getTransactions(transactionNumber: 5)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
