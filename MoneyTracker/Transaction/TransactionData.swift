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

enum TransactionType: String, CaseIterable, Identifiable {
    case Spend, Income
    var id: Self {self}
}

class TransactionData: Identifiable, ObservableObject{
    var id : String
    var amount : String
    @Published var currency : SelectionCurrency
    @Published var category : SelectionCategory
    @Published var paymentMethod : SelectionPay
    var date : Date
    var timestamp: Timestamp
    @Published var transactionType : TransactionType
    
    var dictionary: [String: AnyHashable] {
        return [
            "amount": amount,
            "currency": currency.rawValue,
            "category": category.rawValue,
            "paymentMethod": paymentMethod.rawValue,
            "date": date,
            "timestamp": timestamp,
            "transactionType": transactionType.rawValue
        ]
    }
    
    init(
        id: String? = nil,
        amount: String = "",
        currency: SelectionCurrency = .USD,
        category: SelectionCategory = .Food,
        paymentMethod: SelectionPay = .Card,
        date: Date = Date(),
        timestamp: Timestamp = .init(),
        transactionType : TransactionType = .Spend
    ) {
        self.id = id ?? UUID().uuidString
        self.amount = amount
        self.currency = currency
        self.category = category
        self.paymentMethod = paymentMethod
        self.date = date
        self.timestamp = timestamp
        self.transactionType = transactionType
    }
}




