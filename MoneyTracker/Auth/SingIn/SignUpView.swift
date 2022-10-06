//
//  SignUpView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 16) {
                Text("Sign Up!")
                
                Group{
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                }
                .textInputAutocapitalization(.never)
                
                Button {
                    viewModel.signUp()
                } label: {
                    if viewModel.isSigningUp {
                        HStack(spacing: 16){
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            Text("Singing Up")
                        }
                    } else {
                        Text("Sign Up")
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .disabled(viewModel.isSigningUp)
            }
            .padding()
            .alert("Wrong email", isPresented: $viewModel.signingError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $viewModel.isSignedUp) {
                Text("All good")
            }
        }
    }
}

//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
