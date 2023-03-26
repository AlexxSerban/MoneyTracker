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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Firebase Init
        FirebaseApp.configure()
        
        // Dependencies
        setupDependencies()
        
        return true
    }
    
    func setupDependencies() {
        let container = DIContainer.shared
        
        container.register(type: AuthClient.self, component: AuthClient())
        container.register(type: UserRepository.self, component: UserRepository())
        container.register(type: TransactionRepository.self, component: TransactionRepository())
    }
}

@main
struct MoneyTracker: App {
    // Register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isUserAuthenticated = false
    @State private var showSplashScreen = true
    @AppStorage("isOnbording") var isOnbording : Bool = true
    
    var body: some Scene {
        WindowGroup {
            
            
            ZStack {
                
                if showSplashScreen {
                    
                    SplashScreenView()
                        .transition(.move(edge: .trailing))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut(duration: 0.4).delay(0.1)) {
                                    showSplashScreen = false
                                }
                            }
                            
                        }
                    
                    
                } else {
                    
                    if isOnbording {
                        
                        OnboardingFlowView()
                        
                    } else {
                        
                        NavigationView {
                            if isUserAuthenticated {
                                TabMenuView()
                                    .onAppear(){
                                        withAnimation(.easeIn) {
                                            
                                        }
                                    }
                                
                            } else {
                                LoginView(viewModel: LoginViewModel())
                                    .onAppear(){
                                        withAnimation(.easeIn) {
                                            
                                        }
                                    }
                            }
                        }
                    }
                }
            }
                let _ = Auth.auth().addStateDidChangeListener { auth, user in
                    if let user = user {
                        isUserAuthenticated = true
                        print("Utilizatorul este logat cu adresa de email \(user.email ?? "")")
                    } else {
                        isUserAuthenticated = false
                        print("Utilizatorul nu este logat")
                    }
                }
            }
        }
    }
}
