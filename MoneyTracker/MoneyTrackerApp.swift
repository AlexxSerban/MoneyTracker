//
//  MoneyTrackerApp.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import SwiftUI
import FirebaseCore
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        let container = DIContainer.shared
        container.register(type: AuthClient.self, component: AuthClient())
        container.register(type: UserRepository.self, component: UserRepository())
        
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
                LoginView(viewModel: LoginViewModel())
            }
        }
    }
}
