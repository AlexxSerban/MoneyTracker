//
//  ResetPasswordView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 08.10.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @ObservedObject var viewModel: ResetPasswordViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Please enter your email.")
                
                TextField("Your email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                
                Button {
                    viewModel.resetPassword()
                } label: {
                    Text("Reset")
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            .padding()
            .alert("Please try again", isPresented: $viewModel.forgotError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $viewModel.resetSuccessful) {
                LoginView(viewModel: LoginViewModel())
            }
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(viewModel: ResetPasswordViewModel())
    }
}
