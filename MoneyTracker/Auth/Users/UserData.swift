//
//  UserData.swift
//  MoneyTracker
//
//  Created by Alex Serban on 29.10.2022.
//

import Foundation

class UserData {
    
    var name: String
    var phoneNumber: String
    var country: String
    
    var dictionary: [String: AnyHashable] {
        return ["name": name,
                "phoneNumber": phoneNumber,
                "country": country]
    }
    
    init(name: String, phoneNumber: String, country: String) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.country = country
    }

}
