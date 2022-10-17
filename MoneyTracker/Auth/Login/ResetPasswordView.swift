//
//  ResetPasswordView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 08.10.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Please enter your email.")
                TextField("Your email", text: $loginViewModel.email)
                    .keyboardType(.emailAddress)
                Button {
                    loginViewModel.resetPassword(email: loginViewModel.email)
                    loginViewModel.passwordOk = false
                } label: {
                    Text("Reset")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            .padding()
            .alert("Please try again", isPresented: $loginViewModel.forgotError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $loginViewModel.passwordOk) {
                LoginView(loginViewModel: loginViewModel)
            }
        }
        
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(loginViewModel: LoginViewModel(loginAuthClient: FirebaseAuthClient()))
    }
}
