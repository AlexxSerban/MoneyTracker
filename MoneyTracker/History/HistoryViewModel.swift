//
//  HistoryViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 29.01.2023.
//

import Foundation

class HistoryViewModel: ObservableObject {
    
    // Calendar Selection
    @Published var selectedYear = Calendar.current.component(.year, from: Date())
    @Published var selectedMonth = Calendar.current.shortMonthSymbols[Calendar.current.component(.month, from: Date())-1]
    @Published var months : [String] = Calendar.current.shortMonthSymbols
    @Published var dateRange = Calendar.current.startOfMonth(Date())...Calendar.current.endOfMonth(Date())
    
    // Status
    @Published var isLoadingTransactions: Bool = false
    @Published var showAllTransactions = false
    
    // Data
    @Published var transactionData = [TransactionData()]
    @Published var selectCategory: SelectionCategory = .Food
    @Published var totalMonthlyIncome: Int = 0
    @Published var totalMonthlySpend: Int = 0
    @Published var totalCategorySum: Int = 0
    
    // Dependencies
    let transactionRepository: TransactionRepository
    
    init(transactionRepository: TransactionRepository = DIContainer.shared.resolve(type: TransactionRepository.self)) {
        self.transactionRepository = transactionRepository
    }
    
    func setMonthPeriod(selectedMonth: String) {
        
        self.selectedMonth = selectedMonth
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MMM/yyy"
        let dateString = "01/" + selectedMonth + "/" + String(selectedYear)
        
        guard let startDate = dateFormatter.date(from: dateString) else {
            print("Could not parse date from string: \(dateString)")
            return
        }
        
        guard let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)?.addingTimeInterval(-1) else {
            print("Could not find end of month for start date: \(startDate)")
            return
        }
        
        dateRange = .init(uncheckedBounds: (lower: startDate, upper: endDate))
    }
    
    @MainActor
    func fetchMonthlyTransactions() {
        Task{
            do {
                self.transactionData = try await transactionRepository.getFilteredTransaction(startDate: dateRange.lowerBound, endDate: dateRange.upperBound)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func monthlyIncome() {
        Task{
            do {
                self.totalMonthlyIncome = try await transactionRepository.calculateIncomeSum(startDate: dateRange.lowerBound, endDate: dateRange.upperBound)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func monthlySpend() {
        Task{
            do {
                self.totalMonthlySpend = try await transactionRepository.calculateSpendSum(startDate: dateRange.lowerBound, endDate: dateRange.upperBound)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func categorySum() {
        Task{
            do {
                
                self.totalCategorySum = try await transactionRepository.calculateCategorySum(
                    startDate: dateRange.lowerBound,
                    endDate: dateRange.upperBound,
                    category: SelectionCategory(rawValue: selectCategory.rawValue) ?? .Food
                    
                )
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func updateMonthlyData(selectedMonth: String) {
        
        setMonthPeriod(selectedMonth: selectedMonth)
        isLoadingTransactions = true
        
        Task {
            await fetchMonthlyTransactions()
            await monthlyIncome()
            await monthlySpend()
            await categorySum()
            
            await MainActor.run {
                isLoadingTransactions = false
            }
        }
    }
}
