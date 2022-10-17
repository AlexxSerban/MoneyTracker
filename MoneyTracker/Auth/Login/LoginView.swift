//
//  LogInView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 07.10.2022.
//

import SwiftUI

struct LoginView: View {
    
    @State var toRegister: Bool = false
    
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
                
                Button() {
                    
                } label: {
                    Text("Register")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundColor(Color.orange)
                        
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                Button {
                    loginViewModel.forgotPassword = true
                } label: {
                    Text("Forgot Password")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundColor(Color.green)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)

                
            }
            .padding()
            .alert("Wrong email", isPresented: $loginViewModel.loggingError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $loginViewModel.isLogged) {
                Text("All good")
            }
            .navigationDestination(isPresented: $toRegister) {
                RegisterView(viewModel: RegisterViewModel(firebaseAuthClient: FirebaseAuthClient()))
            }
            .navigationDestination(isPresented: $loginViewModel.forgotPassword) {
                ResetPasswordView(loginViewModel: loginViewModel)
            }
        }
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginViewModel: LoginViewModel.example)
    }
}
