//
//  RegisterView.swift
//  MoneyTracker
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
                    
                    Text("Register")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .offset(y: -70)
                        .foregroundColor(Color("Text"))
                    
                    
                    HStack{
                        
                        VStack{}
                        .frame(width: 420, height: 130)
                        .background(.white, in: RoundedRectangle(cornerRadius: 80, style: .continuous))
                        .shadow(radius: 4)
                        .offset(x: -60, y: -20)
                        .overlay {
                            
                            HStack{
                                
                                Spacer()
                                
                                VStack(spacing: 20) {
                                    
                                    HStack(spacing: 20) {
                                        
                                        Image(systemName: "person")
                                            .foregroundColor(Color("MainColor"))
                                        TextField("Email", text: $viewModel.email, prompt: Text("Email").foregroundColor(Color("SecondText")))
                                            .keyboardType(.emailAddress)
                                            .font(.system(size: 18, weight: .bold, design: .serif))
                                            .foregroundColor(Color.black)
                                            
                                    }
                                    
                                    Divider()
                                        .offset(x: -80)
                                    
                                    HStack(spacing: 20) {
                                        
                                        Image(systemName: "lock")
                                            .foregroundColor(Color("MainColor"))
                                        SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundColor(Color("SecondText")))
                                            .font(.system(size: 18, weight: .bold, design: .serif))
                                            .foregroundColor(Color.black)
                                    }
                                }
                                .padding()
                                .offset(y: -20)
                                .overlay(
                                    
                                    Button {
                                        viewModel.register()
                                    } label: {
                                        if viewModel.isLoading {
                                            
                                            HStack(spacing: 16){
                                                
                                                Circle()
                                                    .fill(Color("MainColor"))
                                                    .frame(width: 80, height: 60)
                                                    .overlay(
                                                        ProgressView()
                                                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                                                    )
                                            }
                                            
                                        } else {
                                            
                                            Circle()
                                                .fill(Color("MainColor"))
                                                .frame(width: 80, height: 60)
                                                .overlay(
                                                    Image(systemName: "checkmark")
                                                        .resizable()
                                                        .padding(10)
                                                        .frame(width: 40, height: 40)
                                                        .foregroundColor(.white)
                                                        .mask(Circle())
                                                )
                                        }
                                    }
                                        .disabled(viewModel.isLoading)
                                        .offset(x: 140, y: -20)
                                        .padding()
                                )
                            }
                        }
                    }
                    
                    HStack{
                        
                        VStack{}
                        .frame(width: 130, height: 50)
                        .background(.white, in: RoundedRectangle(cornerRadius: 50, style: .continuous))
                        .shadow(radius: 1)
                        .offset(x: -170, y: 20)
                        .overlay {
                            Button() {
                                viewModel.toLogin = true
                            } label: {
                                
                                Text("Login")
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                    .foregroundColor(Color("SecondColor"))
                                
                            }
                            .offset(x: -170, y: 20)
                        }
                    }
                    
                }
                .padding()
                .alert("Wrong email", isPresented: $viewModel.registeringError, actions: {
                    Button("Ok") { }
                })
                .navigationDestination(isPresented: $viewModel.toLogin) {
                    LoginView(viewModel: LoginViewModel())
                }.navigationBarBackButtonHidden(true)
                
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
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel())
    }
}
