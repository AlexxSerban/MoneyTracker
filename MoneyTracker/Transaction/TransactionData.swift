//
//  TransactionViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import Foundation
import FirebaseFirestore

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



class TransactionData: Identifiable {
    var id = UUID()
    var amount : String
    var currency : SelectionCurrency
    var category : SelectionCategory
    var paymentMethod : SelectionPay
    var date : Date
    var timestamp: Timestamp
    
    var dictionary: [String: AnyHashable] {
        return [
            "amount": amount,
            "currency": currency.rawValue,
            "category": category.rawValue,
            "paymentMethod": paymentMethod.rawValue,
            "date": date,
            "timestamp": timestamp
        ]
    }
    
    init(
        amount: String = "",
        currency: SelectionCurrency = .USD,
        category: SelectionCategory = .Food,
        paymentMethod: SelectionPay = .Card,
        date: Date = Date(),
        timestamp: Timestamp = .init()
    ) {
        self.amount = amount
        self.currency = currency
        self.category = category
        self.paymentMethod = paymentMethod
        self.date = date
        self.timestamp = timestamp
    }
}



