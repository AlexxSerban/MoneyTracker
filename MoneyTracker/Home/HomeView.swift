//
//  HomeView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI
import Charts

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var offset = CGSize.zero
    @State private var opacity = 0.0
    
    var body: some View {
        
        ZStack{
            
            Color("Background")
                .ignoresSafeArea(.all)
            
            VStack{
                
                HStack{
                    
                    Text("Home")
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundColor(Color("Text"))
                        .offset(x: -140)
                    
                }
                .padding()
                
                VStack{}
                    .frame(width: 300, height: 130)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color("ThirdColor"), Color("MainColor")]),
                                       startPoint: .bottomTrailing, endPoint: .topLeading)
                    )
                    .shadow(radius: 75)
                    .cornerRadius(30)
                    .opacity(0.8)
                //                    .offset(x: -60 + offset.width, y: +50 + offset.height)
                    .shadow(color: Color("MainColor").opacity(0.3), radius: 10, y: 10)
                    .overlay {
                        
                        VStack(alignment: .leading, spacing: 16){
                            
                            Text("\(viewModel.totalIncome - viewModel.totalSpend) \(SelectionCurrency.defaultCurrency.rawValue)")
                                .font(.system(size: 32, weight: .bold, design: .serif))
                                .foregroundColor(Color("Text"))
                            
                            Text("Available Balance")
                                .font(.system(size: 19, design: .serif))
                                .foregroundColor(Color("Text"))
                            
                        }
                        .offset(x: -50 + offset.width, y: +50 + offset.height)
                        .rotationEffect(Angle(degrees: 360))
                        
                    }
                
                    .padding()
                
                HStack(spacing: 15){
                    
                    HStack{
                        
                        VStack{}
                            .frame(width: 160, height: 180)
                            .background(Color("BackgroundBlocks"))
                            .opacity(0.8)
                            .shadow(radius: 15)
                            .cornerRadius(30)
                            .offset(x: 30, y: -10)
                            .overlay {
                                
                                VStack(alignment: .center, spacing: 6){
                                    
                                    VStack{
                                        Circle()
                                            .fill(Color("MainColor"))
                                            .frame(width: 60, height: 50)
                                            .opacity(0.2)
                                            .overlay(
                                                
                                                Image(systemName: "arrow.up")
                                                    .resizable()
                                                    .padding(10)
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(.green)
                                                    .mask(Circle())
                                            )
                                            .offset(x: -40, y:-25)
                                        
                                        
                                        VStack(alignment: .leading, spacing: 8){
                                            
                                            Text("\(viewModel.totalIncome) \(SelectionCurrency.defaultCurrency.rawValue)")
                                                .font(.system(size: 22, weight: .bold, design: .serif))
                                                .foregroundColor(Color("Text"))
                                            
                                            Text("Monthly Income")
                                                .font(.system(size: 16, design: .serif))
                                                .foregroundColor(Color("Text"))
                                            
                                        }
                                    }
                                }
                                .offset(x: 25 + offset.width, y: 40 + offset.height)
                                //                                .offset(x: 25, y: -10)
                            }
                            .padding()
                    }
                    .padding()
                    
                    
                    HStack(spacing: 5){
                        
                        VStack{}
                            .frame(width: 160, height: 180)
                            .background(Color("BackgroundBlocks"))
                            .opacity(0.8)
                            .shadow(radius: 15)
                            .cornerRadius(30)
                            .offset(x: -30, y: -10)
                            .overlay {
                                
                                VStack(alignment: .center,spacing: 6){
                                    
                                    VStack{
                                        
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 60, height: 50)
                                            .opacity(0.2)
                                            .overlay(
                                                
                                                Image(systemName: "arrow.down")
                                                    .resizable()
                                                    .padding(10)
                                                    .frame(width: 40, height: 40)
                                                    .foregroundColor(.red)
                                                    .mask(Circle())
                                            )
                                            .offset(x: -45, y:-25)
                                        
                                        VStack(alignment: .leading, spacing: 8){
                                            
                                            Text("\(viewModel.totalSpend) \(SelectionCurrency.defaultCurrency.rawValue)")
                                                .font(.system(size: 22, weight: .bold, design: .serif))
                                                .foregroundColor(Color("Text"))
                                            
                                            Text("Monthly Spending")
                                                .font(.system(size: 16, design: .serif))
                                                .foregroundColor(Color("Text"))
                                            
                                        }
                                    }
                                }
                                .offset(x:  -30 + offset.width, y: 40 + offset.height)
                                //                                .offset(x: -30, y: -10)
                            }
                            .padding()
                    }
                    .padding()
                }
                
                VStack {
                    
                    if viewModel.transactionData.isEmpty {
                        
                        Text("No transactions found.")
                        
                    } else {
                        
                        if viewModel.isLoadingTransactions {
                            
                            ProgressView("Processing")
                                .tint(.orange)
                                .foregroundColor(.gray)
                            
                        } else {
                            
                            List{
                                
                                Section{
                                    
                                    ForEach(viewModel.transactionData) { transaction in
                                        
                                        HStack(spacing: 20){
                                            
                                            (
                                                transaction.transactionType == .Spend ? Image(systemName: "cart.fill.badge.minus") : Image(systemName: "banknote.fill")
                                            )
                                            .resizable()
                                            .frame(width: 24, height: 26)
                                            .foregroundColor(Color("MainColor"))
                                            
                                            VStack(alignment: .leading, spacing: 6){
                                                
                                                Text("\(transaction.category.rawValue)")
                                                    .font(.headline).bold().italic()
                                                    .minimumScaleFactor(0.5)
                                                    .foregroundColor(Color("Text"))
                                                
                                                Text("\(transaction.timestamp.dateValue().formatted(date: .long , time: .omitted))")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color("Text"))
                                            }
                                            
                                            Spacer()
                                            
                                            VStack(spacing: 5){
                                                
                                                Text("\(transaction.amount) \(transaction.currency.rawValue)")
                                                    .fixedSize(horizontal: true, vertical: false)
                                                    .font(.headline).bold().italic()
                                                    .foregroundColor(transaction.transactionType == .Spend ? Color.red : Color.green)
                                                    .foregroundColor(Color("Text"))
                                                    .frame(maxWidth: .infinity)
                                            }.padding()
                                                .offset(x: 50)
                                            
                                        }
                                        .padding(.vertical, 5)
                                    }
                                    .frame(height: 80)
                                    .listRowBackground(
                                        
                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                                            .fill(Color("BackgroundBlocks"))
                                            .opacity(0.8)
                                            .padding(.vertical, 1)
                                            .cornerRadius(2)
                                        
                                    )
                                    .listStyle(.insetGrouped)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(.init(top: 0, leading: 40, bottom: 0, trailing: 40))
                                    
                                } header: {
                                    
                                    Text("Recent transactions")
                                        .foregroundColor(Color("Text"))
                                    
                                }
                                .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .headerProminence(.increased)
                                
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .scrollContentBackground(.hidden)
                            .animation(.spring(response: 0.8, dampingFraction: 0.8))
                        }
                    }
                }
                .offset(y: -20)
                
                
                Spacer()
                
            }
        }
        .onAppear {
            self.viewModel.getLastTransactions()
            self.viewModel.calculateMonthlyIncome()
            self.viewModel.calculateMonthlySpend()
            
            withAnimation(Animation.easeInOut(duration: 1.0).delay(0.5)) {
                offset = CGSize(width: 0, height: -50)
                opacity = 0.8
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
