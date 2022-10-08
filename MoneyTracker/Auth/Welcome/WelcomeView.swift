//
//  WelcomeView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 08.10.2022.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var transitionViewModel = TransitionViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16){
                Text("Welcome!")
                
                HStack{
                    Button {
                        transitionViewModel.toLogin = true
                    } label: {
                        Text("Log In")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    
                    Button {
                        transitionViewModel.toRegister = true
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                }
            }
            .navigationDestination(isPresented: $transitionViewModel.toLogin) {
                LoginView(loginViewModel: LoginViewModel(loginAuthClient: FirebaseAuthClient()), transitionViewModel: TransitionViewModel())
            }
            .navigationDestination(isPresented: $transitionViewModel.toRegister) {
                RegisterView(viewModel: RegisterViewModel(firebaseAuthClient: FirebaseAuthClient()), transitionViewModel: TransitionViewModel())
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
