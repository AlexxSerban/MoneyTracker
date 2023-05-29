//
//  RegisterView.swift
//  Peso
//
//  Created by Alex Serban on 06.10.2022.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Text("Register")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .offset(y: -70)
                        .foregroundColor(Color("Text"))
                    
                    
                   
                            
                            VStack(spacing: 20) {
                                
                                HStack(spacing: 20) {
                                    
                                    Image(systemName: "person")
                                        .foregroundColor(Color("MainColor"))
                                    TextField("Email", text: $viewModel.email, prompt: Text("Email").foregroundColor(Color("Text")))
                                        .keyboardType(.emailAddress)
                                        .font(.system(size: 18, weight: .bold, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    
                                }
                                
                                Divider()
                                
                                HStack(spacing: 20) {
                                    
                                    Image(systemName: "lock")
                                        .foregroundColor(Color("MainColor"))
                                    SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundColor(Color("Text")))
                                        .font(.system(size: 18, weight: .bold, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    
                                }
                            }
                            .padding()
                    
                    Spacer()
                        .frame(height: 110)
                        
                        VStack{
                            
                            Button {
                                viewModel.register()
                            } label: {
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .frame(width: 310, height: 45)
                                    .foregroundColor(Color("MainColor"))
                                    .overlay(
                                        Text("Register")
                                            .font(.system(size: 18, weight: .bold, design: .serif))
                                            .foregroundColor(.white)
                                    )
                                
                            }
                            
                            HStack{
                                
                                Rectangle()
                                    .frame( height: 1)
                                    .foregroundColor(Color("SecondText"))
                                Text("OR")
                                    .padding(.horizontal, 8)
                                    .foregroundColor(Color("SecondText"))
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("SecondText"))
                                
                            }
                            .padding()
                            
                            Button() {
                                viewModel.toLogin = true
                            } label: {
                                
                                RoundedRectangle(cornerRadius: 10,style: .continuous)
                                    .frame(width: 310, height: 45)
                                    .foregroundColor(Color("MainColor"))
                                    .overlay(
                                Text("Login")
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                    .foregroundColor(.white)
                                )
                            }
                            
                        }
                        .padding()
                    }
                    .padding()
                    .alert("Wrong email", isPresented: $viewModel.registeringError, actions: {
                        Button("Ok") { }
                    })
                    .navigationDestination(isPresented: $viewModel.toLogin) {
                        LoginView(viewModel: LoginViewModel())
                    }.navigationBarBackButtonHidden(true)
                    
                    
                }
            }
        }
    }
    
    struct RegisterView_Previews: PreviewProvider {
        static var previews: some View {
            RegisterView(viewModel: RegisterViewModel())
        }
    }
