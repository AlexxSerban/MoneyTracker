//
//  ResetPasswordView.swift
//  Peso
//
//  Created by Alex Serban on 08.10.2022.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @ObservedObject var viewModel: ResetPasswordViewModel
    
    var body: some View {
        NavigationStack {
            
            ZStack{
                
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(spacing: 16) {
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Text("Reset password")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .offset(y: -40)
                        .foregroundColor(Color("Text"))
                    
                    VStack(){
                        
                        VStack(alignment: .leading){
                            Text("Enter the email associated with your account and we'll send an email with instructions to reset your password.")
                                .foregroundColor(Color("SecondText"))
                        }
                        .padding()
                        
                        
                        
                        VStack(spacing: 0){
                            
                            HStack(spacing: 20) {
                                
                                Image(systemName: "person")
                                    .foregroundColor(Color("MainColor"))
                                TextField("", text: $viewModel.email, prompt: Text("Your email").foregroundColor(Color("SecondText")))
                                    .keyboardType(.emailAddress)
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                    .foregroundColor(Color("SecondText"))
                                
                            }.padding()
                            
                            Divider()
                                .frame(width: 340)
                        }
                        .padding()
                        
                    }
                    
                    
                    Spacer()
                        .frame(height: 200)
                    
                    Button {
                        viewModel.resetPassword()
                    } label: {
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .frame(width: 310, height: 45)
                            .foregroundColor(Color("MainColor"))
                            .overlay(
                                Text("Reset")
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                    .foregroundColor(.white)
                            )
                    }
                    
                    .padding()
                }
                
                .alert("Please try again", isPresented: $viewModel.forgotError, actions: {
                    Button("Ok") { }
                })
                
            }
            
            .navigationDestination(isPresented: $viewModel.toLogin) {
                LoginView(viewModel: LoginViewModel())
            }.navigationBarBackButtonHidden(true)
            
            
            
        }
        .navigationDestination(isPresented: $viewModel.toLogin) {
            LoginView(viewModel: LoginViewModel())
        }.navigationBarBackButtonHidden(true)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(viewModel: ResetPasswordViewModel())
    }
}
