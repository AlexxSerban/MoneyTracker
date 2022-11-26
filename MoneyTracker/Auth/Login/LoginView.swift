//
//  LogInView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 07.10.2022.
//

import SwiftUI

struct LoginView: View {
    
    @State var toRegister: Bool = false
    @State var forgotPassword: Bool = false
    
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        NavigationStack{
            VStack(spacing: 16) {
                
                Text("Log In")
                
                Group{
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                }
                
                Button {
                    viewModel.login()
                } label: {
                    if viewModel.isLogging {
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
                .disabled(viewModel.isLogging)
                
                Button() {
                    toRegister = true
                } label: {
                    Text("Register")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundColor(Color.orange)
                        
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                
                Button {
                    forgotPassword = true
                } label: {
                    Text("Forgot Password")
                        .font(.system(size: 18, weight: .bold, design: .serif))
                        .foregroundColor(Color.green)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)

                
            }
            .padding()
            .alert("Wrong email", isPresented: $viewModel.loggingError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $viewModel.isLogged) {
                TabMeniuView()
            }
            .navigationDestination(isPresented: $toRegister) {
                RegisterView(viewModel: RegisterViewModel())
            }
            .navigationDestination(isPresented: $forgotPassword) {
                ResetPasswordView(viewModel: ResetPasswordViewModel())
            }
        }    
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
