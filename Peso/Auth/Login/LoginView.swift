//
//  LogInView.swift
//  Peso
//
//  Created by Alex Serban on 07.10.2022.
//

import SwiftUI


struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    
                    Spacer()
                        .frame(height: 80)
                    
                    Text("Login")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .offset(y: -40)
                        .foregroundColor(Color("Text"))
                    
                    
                    
                    VStack(spacing: 20) {
                        
                        HStack(spacing: 20) {
                            
                            Image(systemName: "person")
                                .foregroundColor(Color("MainColor"))
                            TextField("Email", text: $viewModel.email, prompt: Text("Email").foregroundColor(Color("Text")))
                                .font(.system(size: 18, weight: .bold, design: .serif))
                                .foregroundColor(Color("Text"))
                                .keyboardType(.emailAddress)
                            
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
                    
                    
                    
                    Button {
                        
                        viewModel.forgotPassword = true
                        print("Forgot Password Ok")
                        print("\(viewModel.forgotPassword)")
                    } label: {
                        
                        Text("Forgot?")
                            .font(.system(size: 18, weight: .bold, design: .serif))
                            .foregroundColor(Color("SecondText"))
                    }
                    .padding()
                    .offset(x: 120)
                    
                    Spacer()
                        .frame(height: 60)
                    
                    VStack{
                        
                        Button {
                            viewModel.login()
                        } label: {
                            
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .frame(width: 320, height: 45)
                                .foregroundColor(Color("MainColor"))
                                .overlay(
                                    Text("Login")
                                        .font(.system(size: 18, weight: .bold, design: .serif))
                                        .foregroundColor(.white)
                                )
                            
                        }
                        
                        HStack{
                            
                            Rectangle()
                                .frame(height: 1)
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
                            
                            viewModel.toRegister = true
                            
                        } label: {
                            
                            RoundedRectangle(cornerRadius: 10,style: .continuous)
                                .frame(width: 320, height: 45)
                                .foregroundColor(Color("MainColor"))
                                .overlay(
                                    Text("Register")
                                        .font(.system(size: 18, weight: .bold, design: .serif))
                                        .foregroundColor(.white)
                                )
                        }
                        
                    }
                    .padding()
                }
                .padding()
                .alert("Wrong email", isPresented: $viewModel.loggingError, actions: {
                    Button("Ok") { }
                })
                .navigationDestination(isPresented: $viewModel.isLogged) {
                    TabMenuView()
                }
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $viewModel.toRegister) {
                    RegisterView(viewModel: RegisterViewModel())
                }
                .navigationBarBackButtonHidden(true)
                
            }
            .navigationDestination(isPresented: $viewModel.forgotPassword) {
                ResetPasswordView(viewModel: ResetPasswordViewModel())
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}






