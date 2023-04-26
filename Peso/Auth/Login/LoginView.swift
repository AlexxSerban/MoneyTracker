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
                    
                    Text("Login")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .offset(y: -40)
                        .foregroundColor(Color("Text"))
                                    
                    HStack{
                        
                        VStack{}
                        .frame(width: 420, height: 130)
                        .background(.white, in: RoundedRectangle(cornerRadius: 80, style: .continuous))
                        .shadow(radius: 4)
                        .offset(x: -60)
                        .overlay {
                            
                            HStack{
                                
                                Spacer()
                                
                                VStack(spacing: 20) {
                                    
                                    HStack(spacing: 20) {
                                        
                                        Image(systemName: "person")
                                            .foregroundColor(Color("MainColor"))
                                        TextField("Email", text: $viewModel.email, prompt: Text("Email").foregroundColor(Color("SecondText")))
                                            .font(.system(size: 18, weight: .bold, design: .serif))
                                            .foregroundColor(Color.black)
                                            .keyboardType(.emailAddress)
                                        
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
                                .overlay(
                                    
                                    Button {
                                        viewModel.login()
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
                        .padding()
                    }
                    
                    Button {
                        
                        viewModel.forgotPassword = true
                        print("Forgot Password Ok")
                        print("\(viewModel.forgotPassword)")
                    } label: {
                        
                        Text("Forgot ?")
                            .font(.system(size: 18, weight: .bold, design: .serif))
                            .foregroundColor(Color("SecondText"))
                    }
                    .padding()
                    .offset(x: 140)
                    
                    
                    HStack{
                        
                        VStack{}
                        .frame(width: 160, height: 50)
                        .background(.white, in: RoundedRectangle(cornerRadius: 50, style: .continuous))
                        .shadow(radius: 1)
                        .offset(x: -170)
                        .overlay {
                            
                            Button() {
                                viewModel.toRegister = true
                                
                            } label: {
                                
                                Text("Register")
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                    .foregroundColor(Color("SecondColor"))
                                
                            }
                            .offset(x: -155)
                            
                        }
                        .padding()
                    }
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

struct WaveRoundedRectangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in
            
            //For Curve Shape 100
            let width = rect.size.width - 100
            let height = rect.size.height
            
            path.move(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            
            // Curve
            path.move(to: CGPoint(x: width, y: 0))
            
            path.addCurve(to: CGPoint(x: width, y: height + 20),
                          control1: CGPoint(x: width + 180, y: height / 2),
                          control2: CGPoint(x: width - 210, y: height / 10))
        }
    }
}




