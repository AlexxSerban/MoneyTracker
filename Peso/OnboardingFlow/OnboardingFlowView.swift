//
//  OnboardingFlowView.swift
//  Peso
//
//  Created by Alex Serban on 22.03.2023.
//

import SwiftUI

struct OnboardingFlowView: View {
   
    @State private var currentPageIndex = 0
    @State var showButton: Bool = false
    @AppStorage("isOnbording") var isOnbording : Bool?
    
    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea(.all)
            
            TabView(selection: $currentPageIndex){
                
                OnboardView(
                    systemImageName: "OBWelcome",
                    title: "Welcome",
                    description: "We provide support to help you track your income and expenses, make better financial decisions, and achieve your financial goals. Let's start together on the road to simplifying your financial life."
                )
                .tag(0)
                
                OnboardView(
                    systemImageName: "OBWelcome2",
                    title: "Take control of your finances",
                    description: "Do you find it difficult to keep track of your expenses and income? With a few clicks, you can easily monitor your spending and income, allowing you to make informed decisions about your finances."
                )
                .tag(1)
                
                OnboardView(
                    systemImageName: "OBWelcome3",
                    title: "Let's get started",
                    description: "Keeping a focused attention on the charts and summaries in your data is essential to get a clear perspective on the information you are managing."
                )
                .tag(2)
                
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            if currentPageIndex == 2 && showButton {
                Button(action: {
                    isOnbording = false
                }, label: {
                    Text("Start")
                        .padding()
                        .background(
                            Capsule()
                                .strokeBorder(Color("MainColor"), lineWidth: 1.5)
                                .frame(width: 100)
                        )
                })
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 120, height: 50)
                .background(Color("MainColor"))
                .cornerRadius(30)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut)
                .offset(y: 310)
            }
        }
        .onAppear {
            showButton = false
        }
        .onChange(of: currentPageIndex) { newValue in
            showButton = newValue == 2
        }
    }
}

struct OnboardingFlowView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlowView()
    }
}

struct OnboardView: View {
    
    var systemImageName: String
    var title: String
    var description: String
    
    var body: some View {
        
        ZStack{
            
            VStack(spacing: 35){
                
                Image(systemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                Text(title)
                    .font(.title).bold()
                    .foregroundColor(Color("Text"))
                
                Text(description)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("SecondText"))
                
            }
            .padding(.horizontal, 40)
        }
    }
}
