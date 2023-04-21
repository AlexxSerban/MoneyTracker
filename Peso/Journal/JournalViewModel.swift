//
//  JournalViewModel.swift
//  Peso
//
//  Created by Alex Serban on 15.12.2022.
//

import Foundation
import FirebaseFirestore
import Charts

enum PeriodSection : String, CaseIterable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
    case year = "Year"
}

class JournalViewModel: ObservableObject {
    
    @Published var model = JournalModel()
    
    // Transaction Data
    @Published var transactionData = [TransactionData()]
    @Published var transactionDataFiltered : [TransactionData] = []
    
    // Values for the time period
    @Published var periodSection : PeriodSection = .day
    var startDate : Date = Date()
    var endDate : Date = Date()
    
    // Status
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
                
                switch periodSection {
                case .day:
                    startDate = model.startOfDay
                    endDate = model.endOfDay
                    
                case .week:
                    startDate = model.startOfWeek
                    endDate = model.endOfWeek
                    
                case .month:
                    startDate = model.startOfMonth
                    endDate = model.endOfMonth
                    
                case .year:
                    startDate = model.startOfYear
                    endDate = model.endOfYear
                }
                
                self.transactionData = try await transactionRepository.getFilteredTransaction(startDate: startDate, endDate: endDate, currency: SelectionCurrency(rawValue: SelectionCurrency.defaultCurrency.rawValue) ?? .USD)
                
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
                
                self.transactionDataFiltered = try await transactionRepository.getSpendTransactions(periodSection: periodSection, startDate: startDate, endDate: endDate, currency: SelectionCurrency(rawValue: SelectionCurrency.defaultCurrency.rawValue) ?? .USD)
                
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
