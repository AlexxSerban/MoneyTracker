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
    @Published var journalModel = JournalModel()
    @Published var totalIncome: Int = 0
    @Published var totalSpend: Int = 0
    
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
    
    @MainActor
    func calculateMonthlyIncome() {
        Task{
            do {
                self.totalIncome = try await transactionRepository.calculateIncomeSum(startDate: journalModel.startOfMonth, endDate: journalModel.endOfMonth)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func calculateMonthlySpend() {
        Task{
            do {
                self.totalSpend = try await transactionRepository.calculateSpendSum(startDate: journalModel.startOfMonth, endDate: journalModel.endOfMonth)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
