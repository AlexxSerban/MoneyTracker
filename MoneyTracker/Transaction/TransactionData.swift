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
    
    static var defaultCurrency: SelectionCurrency {
        get {
            if let rawValue = UserDefaults.standard.string(forKey: "defaultCurrency"), let currency = SelectionCurrency(rawValue: rawValue) {
                return currency
            }
            return .USD // sau alta valoare implicita
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "defaultCurrency")
        }
    }
}


enum SelectionCategory: String, CaseIterable, Identifiable {
    case Food, Education, Pets, Fitness, Salary, Business, Gifts 
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
    var date : Date
    var timestamp: Timestamp
    @Published var transactionType : TransactionType
    
    var dictionary: [String: AnyHashable] {
        
        return [
            "amount": amount,
            "currency": currency.rawValue,
            "category": category.rawValue,
            "date": date,
            "timestamp": timestamp,
            "transactionType": transactionType.rawValue
        ]
        
    }
    
    init(
        
        id: String? = nil,
        amount: String = "",
        currency: SelectionCurrency = SelectionCurrency.defaultCurrency,
        category: SelectionCategory = .Food,
        date: Date = Date(),
        timestamp: Timestamp = .init(),
        transactionType : TransactionType = .Spend
        
    ) {
        
        self.id = id ?? UUID().uuidString
        self.amount = amount
        self.currency = currency 
        self.category = category
        self.date = date
        self.timestamp = timestamp
        self.transactionType = transactionType
        
    }
    
    func setCurrency(to currency: SelectionCurrency) {
        self.currency = currency
        TransactionData.saveDefaultCurrency(currency: currency)
    }
    
    static func defaultCurrency() -> SelectionCurrency {
        let defaults = UserDefaults.standard
        let defaultCurrencyRawValue = defaults.string(forKey: "defaultCurrency") ?? SelectionCurrency.USD.rawValue
        return SelectionCurrency(rawValue: defaultCurrencyRawValue) ?? .USD
    }
    
    static func saveDefaultCurrency(currency: SelectionCurrency) {
        let defaults = UserDefaults.standard
        defaults.set(currency.rawValue, forKey: "defaultCurrency")
    }
    
}





