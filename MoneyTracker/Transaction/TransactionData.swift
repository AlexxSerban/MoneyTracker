//
//  TransactionViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import Foundation

class TransactionData {
    
    enum SelectionCurrency: String, CaseIterable, Identifiable {
        case RON, EUR, USD, GBP, JPY
        var id: Self {self}
    }
    enum SelectionCategory: String, CaseIterable, Identifiable {
        case Food, Education, Pets, Fitness
        var id: Self {self}
    }
    enum SelectionPay: String, CaseIterable, Identifiable {
        case Cash, Card
        var id: Self {self}
    }
    
    var amount : String = ""
    @Published var currency : SelectionCurrency = .RON
    @Published var category : SelectionCategory = .Food
    @Published var paymentMethod : SelectionPay = .Card
    var date = Date.now
    
    var dictionary: [String: AnyHashable] {
        return ["amount": amount,
                "currency": currency.rawValue,
                "category": category.rawValue,
                "paymentMethod": paymentMethod.rawValue,
                "date": date]
    }
    
    init(amount: String = "", currency: SelectionCurrency , category: SelectionCategory, paymentMethod: SelectionPay, date: Date = Date.now) {
        self.amount = amount
        self.currency = currency
        self.category = category
        self.paymentMethod = paymentMethod
        self.date = date
    }
}
 
