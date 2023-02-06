//
//  JournalViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 15.12.2022.
//

import Foundation
import FirebaseFirestore

class JournalViewModel: ObservableObject {
    
    @Published var model = JournalModel()
    
    enum PeriodSection : String, CaseIterable {
        case day = "Day"
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    
    @Published var transactionData = [TransactionData()]
    @Published var segmentationSelection : PeriodSection = .day
    var startDate : Date = Date()
    var endDate : Date = Date()
    
    // Dependencies
    let transactionRepository: TransactionRepository
    
    init(transactionRepository: TransactionRepository = DIContainer.shared.resolve(type: TransactionRepository.self)) {
        self.transactionRepository = transactionRepository
    }
    
    @MainActor
    func fetchTransactions() {
        Task{
            do {
                if (segmentationSelection == .day) {
                    startDate = model.startOfDay
                    endDate = model.endOfDay
                } else if (segmentationSelection == .week) {
                    startDate = model.startOfWeek
                    endDate = model.endOfWeek
                } else if(segmentationSelection == .month) {
                    startDate = model.startOfMonth
                    endDate = model.endOfMonth
                } else if(segmentationSelection == .year) {
                    startDate = model.startOfYear
                    endDate = model.endOfYear
                }
                self.transactionData = try await transactionRepository.getFilteredTransaction(startDate: startDate, endDate: endDate)
            } catch {
                print(error.localizedDescription)
            }
        }
        print("Calendar: \(model.calendar)")
        print("Date: \(model.date)")
        print("Start of day: \(model.startOfDay)")
        print("End of day: \(model.endOfDay)")
        print("Current day: \(model.currentDay)")
        print("Start of week: \(model.startOfWeek)")
        print("End of week \(model.endOfWeek)")
        print("Start of month: \(model.startOfMonth)")
        print("End of month \(model.endOfMonth)")
        print("Start of year: \(model.startOfYear)")
        print("End of year \(model.endOfYear)")
        print("Date components\(model.dateComponents)")
    }
}
