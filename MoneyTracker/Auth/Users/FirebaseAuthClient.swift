//
//  FirebaseAuthClient.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import Foundation
import Firebase

class FirebaseAuthClient {
    
    func createUser(user: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: user, password: password) { result, error in
            if error == nil {
                onSuccess()
            } else {
                onFailure()
            }
        }
    }
}
