//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import SwiftUI
import FirebaseCore
import Firebase

final class AppDependencyContainer {
    var firebaseAuthClient = FirebaseAuthClient()
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencyContainer = AppDependencyContainer()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct MoneyTracker: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView(loginViewModel: LoginViewModel(loginAuthClient: delegate.dependencyContainer.firebaseAuthClient))
//                SignUpView(viewModel: SignUpViewModel(firebaseAuthClient: delegate.dependencyContainer.firebaseAuthClient))
                
            }
        }
    }
}
