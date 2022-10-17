//
//  WelcomeViewModel.swift
//  MoneyTracker
//
//  Created by Alex Serban on 08.10.2022.
//

import Foundation

class TransitionViewModel: ObservableObject {
    
    @Published var toRegister: Bool = false
    @Published var toLogin: Bool = false
}

extension TransitionViewModel {
    static let welcomeExample = TransitionViewModel()
}
