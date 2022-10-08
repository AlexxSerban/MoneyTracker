//
//  LogInView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 07.10.2022.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                
                Text("Log In")
                
                Group{
                    TextField("Email", text: $loginViewModel.email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $loginViewModel.password)
                }
                
                Button {
                    loginViewModel.login()
                } label: {
                    if loginViewModel.isLogging {
                        HStack(spacing: 16){
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            Text("Logging")
                        }
                    } else {
                        Text("Log In")
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .disabled(loginViewModel.isLogging)
            }
            .padding()
            .alert("Wrong email", isPresented: $loginViewModel.loggingError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $loginViewModel.isLogged) {
                Text("All good")
            }
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel.example)
    }
}
