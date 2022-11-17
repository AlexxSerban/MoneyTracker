//
//  TransactionViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import Foundation

class TransactionViewModel: ObservableObject {
    
    @Published var selection = "RON"
    @Published var currency = ["RON", "EUR", "USD", "GBP", "JPY"]
    @Published var selectionCategory = "Food"
    @Published var category = ["Food","Education","Pets","Fitness"]
    @Published var selectionPay = "Pe caiet"
    @Published var howIPay = ["Cash","Card","Pe caiet"]
    @Published var date = Date.now
}
