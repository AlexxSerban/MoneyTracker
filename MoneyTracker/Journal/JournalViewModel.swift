//
//  JournalViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 15.12.2022.
//

import Foundation
import FirebaseFirestore
import Charts



class JournalViewModel: ObservableObject {
    
    @Published var model = JournalModel()
    
    enum PeriodSection : String, CaseIterable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
    @Published var transactionData = [TransactionData()]
    @Published var periodSection : PeriodSection = .day
    @Published var transactionDataFiltered : [TransactionData] = []
    var startDate : Date = Date()
    var endDate : Date = Date()
    @Published var isLoadingTransaction: Bool = false
    @Published var isLoadingChart: Bool = false
    
    // Dependencies
    let transactionRepository: TransactionRepository
    
    init(transactionRepository: TransactionRepository = DIContainer.shared.resolve(type: TransactionRepository.self)) {
        self.transactionRepository = transactionRepository
    }
    
    @MainActor
    func fetchTransactions() {
        Task{
            do {
                isLoadingTransaction = true
                if (periodSection == .day) {
                    startDate = model.startOfDay
                    endDate = model.endOfDay
                } else if (periodSection == .week) {
                    startDate = model.startOfWeek
                    endDate = model.endOfWeek
                } else if(periodSection == .month) {
                    startDate = model.startOfMonth
                    endDate = model.endOfMonth
                } else if(periodSection == .year) {
                    startDate = model.startOfYear
                    endDate = model.endOfYear
                }
                self.transactionData = try await transactionRepository.getFilteredTransaction(startDate: startDate, endDate: endDate)
                
                await MainActor.run {
                    isLoadingTransaction = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func fetchSpendTransactions() {
        Task{
            do {
                isLoadingChart = true
                if (periodSection == .day) {
                    startDate = model.startOfDay
                    endDate = model.endOfDay
                    self.transactionDataFiltered = try await transactionRepository.getSpendDailyTransaction(startDate: startDate, endDate: endDate)
                }
                else if (periodSection == .week) {
                    startDate = model.startOfWeek
                    endDate = model.endOfWeek
                    self.transactionDataFiltered = try await transactionRepository.getSpendWeeklyTransaction(startDate: startDate, endDate: endDate)
                } else if(periodSection == .month) {
                    startDate = model.startOfMonth
                    endDate = model.endOfMonth
                    self.transactionDataFiltered = try await transactionRepository.getSpendMonthlyTransaction(startDate: startDate, endDate: endDate)
                } else if(periodSection == .year) {
                    startDate = model.startOfYear
                    endDate = model.endOfYear
                    self.transactionDataFiltered = try await transactionRepository.getSpendYearTransaction(startDate: startDate, endDate: endDate)
                }
                await MainActor.run {
                    isLoadingChart = false
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func deleteTransactionJournalView(at indexSet: IndexSet)  {
        transactionRepository.deleteTransactionFromFirestore(at: indexSet, transactionData: transactionData)
        fetchTransactions()
        fetchSpendTransactions()
    }
}
