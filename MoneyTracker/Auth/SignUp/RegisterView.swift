//
//  RegisterView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 06.10.2022.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 16) {
                Text("Register !")
                
                Group{
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.password)
                }
                .textInputAutocapitalization(.never)
                
                Button {
                    viewModel.register()
                } label: {
                    if viewModel.isRegistering {
                        HStack(spacing: 16){
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            Text("Registering")
                        }
                    } else {
                        Text("Register")
                    }
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .disabled(viewModel.isRegistering)
            }
            .padding()
            .alert("Wrong email", isPresented: $viewModel.registeringError, actions: {
                Button("Ok") { }
            })
            .navigationDestination(isPresented: $viewModel.isRegistered) {
                Text("All good")
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel.example)
    }
}
