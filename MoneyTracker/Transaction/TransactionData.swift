//
//  TransactionViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import Foundation

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

class TransactionData {
    
    var amount : String
    var currency : SelectionCurrency
    var category : SelectionCategory
    var paymentMethod : SelectionPay
    var date: Date
    
    var dictionary: [String: AnyHashable] {
        return [
            "amount": amount,
            "currency": currency.rawValue,
            "category": category.rawValue,
            "paymentMethod": paymentMethod.rawValue,
            "date": date
        ]
    }
    
    init(
        amount: String = "",
        currency: SelectionCurrency = .RON,
        category: SelectionCategory = .Food,
        paymentMethod: SelectionPay = .Card,
        date: Date = Date.now
    ) {
        self.amount = amount
        self.currency = currency
        self.category = category
        self.paymentMethod = paymentMethod
        self.date = date
    }
}

