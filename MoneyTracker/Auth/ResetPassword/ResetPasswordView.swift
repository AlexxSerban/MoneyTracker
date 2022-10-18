//
//  ResetPasswordView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 08.10.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @ObservedObject var resetPasswordViewModel: ResetPasswordViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Please enter your email.")
                TextField("Your email", text: $resetPasswordViewModel.email)
                    .keyboardType(.emailAddress)
                Button {
                    resetPasswordViewModel.resetPassword(email: resetPasswordViewModel.email)
                    resetPasswordViewModel.resetOk = true
                } label: {
                    Text("Reset")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            .padding()
            .alert("Please try again", isPresented: $resetPasswordViewModel.forgotError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $resetPasswordViewModel.resetOk) {
                LoginView(loginViewModel: LoginViewModel())
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(resetPasswordViewModel: ResetPasswordViewModel())
    }
}
