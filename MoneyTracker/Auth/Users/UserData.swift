//
//  UserData.swift
//  MoneyTracker
//
//  Created by Alex Serban on 29.10.2022.
//

import Foundation

class UserData: ObservableObject {
    
    var id: String
    var email: String
    var name: String
//    var firstName: String = ""
//    var lastName: String = ""
    var phoneNumber: String
    
    var dictionary: [String: AnyHashable] {
        return ["id": id,
                "email": email,
                "name": name,
//                "firstName": firstName,
//                "lastName": lastName,
                "phoneNumber": phoneNumber]
    }
    
    init(id: String, email: String, name: String, phoneNumber: String) {
        self.id = id
        self.email = email
        self.name = name
        self.phoneNumber = phoneNumber
    }
//
//    init(document : DocumentSnapshot) {
//        self.id = document.documentID
//        self.email = document.get("email") as! String
//        self.password = document.get("password") as! String
//        self.name = document.get("name") as! String
////        self.firstName = document.get("firstName") as! String
////        self.lastName = document.get("lastName") as! String
//        self.phoneNumber = document.get("phoneNumber") as! String
//    }
}
