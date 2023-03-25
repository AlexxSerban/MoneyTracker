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
            
            ZStack{
                
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [Color("ThirdColor")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 350, height: 500)
                    .clipShape(WaveRoundedRectangle())
                    .background(
                        
                        WaveRoundedRectangle()
                            .stroke(
                                .linearGradient(colors: [
                                    
                                    Color(.black).opacity(0.3),
                                    Color(.black).opacity(0.3),
                                    Color(.black).opacity(0.3),
                                    Color(.black).opacity(0.3)
                                
                                ], startPoint: .top, endPoint: .bottom),
                                lineWidth: 20
                                
                            )
                            .opacity(0.4)
                    )
                    .rotationEffect(.degrees(60))
                    .offset(x: -40,y: -380)
                
                
                VStack(spacing: 16) {
                    
                    Text("Please enter your email.")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .offset(y: -40)
                        .foregroundColor(Color("Text"))
                    
                    HStack{
                        VStack{}
                        .frame(width: 420, height: 60)
                        .background(Color("BackgroundBlocks"), in: RoundedRectangle(cornerRadius: 80, style: .continuous))
                        .shadow(radius: 4)
                        .offset(x: -60)
                        .overlay {
                            
                            HStack{
                                
                                Spacer()
                                
                                VStack(spacing: 20) {
                                    
                                    HStack(spacing: 20) {
                                        
                                        Image(systemName: "person")
                                            .foregroundColor(Color("MainColor"))
                                        TextField("", text: $viewModel.email, prompt: Text("Your email").foregroundColor(Color("SecondText")))
                                            .keyboardType(.emailAddress)
                                            .font(.system(size: 18, weight: .bold, design: .serif))
                                            .foregroundColor(Color.black)
                                            
                                    }
                                }
                                .padding()
                                .overlay(
                                    
                                    Button {
                                        viewModel.resetPassword()
                                    } label: {
                                        if viewModel.isLoading {
                                            HStack(spacing: 16){
                                                
                                                Circle()
                                                    .fill(Color("MainColor"))
                                                    .frame(width: 50, height: 50)
                                                    .overlay(
                                                        ProgressView()
                                                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                                                    )
                                            }
                                            
                                        } else {
                                            Circle()
                                                .fill(Color("MainColor"))
                                                .frame(width: 50, height: 50)
                                                .overlay(
                                                    
                                                    Image(systemName: "arrow.right")
                                                        .resizable()
                                                        .padding(10)
                                                        .frame(width: 40, height: 40)
                                                        .foregroundColor(.white)
                                                        .mask(Circle())
                                                )
                                        }
                                    }
                                        .disabled(viewModel.isLoading)
                                        .offset(x: 140)
                                        .padding()
                                )
                            }
                        }
                    }
                }
                .padding()
                .alert("Please try again", isPresented: $viewModel.forgotError, actions: {
                    Button("Ok") { }
                })
                
                
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [Color("SecondColor")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 400, height: 680)
                    .clipShape(WaveRoundedRectangle())
                    .background(
                        
                        WaveRoundedRectangle()
                            .stroke(
                                .linearGradient(colors: [
                                    Color(.black).opacity(0.3),
                                    Color(.black).opacity(0.3),
                                    Color(.black).opacity(0.3),
                                    Color(.black).opacity(0.3)
                                
                                ], startPoint: .top, endPoint: .bottom),
                                lineWidth: 20
                            )
                            .opacity(0.4)
                    )
                    .rotationEffect(.degrees(-130))
                    .offset(x: 70 ,y: 370)
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
