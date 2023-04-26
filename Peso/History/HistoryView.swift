//
//  HistoryView.swift
//  Peso
//
//  Created by Alex Serban on 29.01.2023.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel = HistoryViewModel()
    
    init() {
        
        self.viewModel.updateMonthlyData(selectedMonth: viewModel.selectedMonth)
        
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            
            Color("Background")
                .ignoresSafeArea(.all)
            
            VStack(spacing: 16){
                
                Group{
                    
                    HStack{
                        
                        Button(action: {
                            
                            self.viewModel.selectedYear -= 1
                            self.viewModel.updateMonthlyData(selectedMonth: viewModel.selectedMonth)
                            
                        }) {
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text(String(viewModel.selectedYear)).foregroundColor(.white)
                            .transition(.move(edge: .trailing))
                        
                        Spacer()
                        
                        Button(action: {
                            
                            self.viewModel.selectedYear += 1
                            self.viewModel.updateMonthlyData(selectedMonth: viewModel.selectedMonth)
                            
                        }) {
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                            
                        }
                    }
                    .padding(.all, 12.0)
                    .background(Color("MainColor"))
                }
                
                Group {
                    
                    ScrollView(.horizontal) {
                        
                        HStack() {
                            
                            ForEach(viewModel.months, id: \.self) { item in
                                Text(item)
                                    .foregroundColor((item == viewModel.selectedMonth) ? Color("MainColor") : .secondary)
                                    .padding(.all, 12.0)
                                    .onTapGesture {
                                        self.viewModel.setMonthPeriod(selectedMonth: item)
                                    }
                            }
                        }
                    }
                    
                }
                
                Divider()
                
                ScrollView(.horizontal){
                    
                    HStack(spacing: 20){
                        
                        Spacer()
                            .frame(width: -5)
                        
                        VStack{}
                            .frame(width: 150, height: 140)
                            .background(Color("MainColor"))
                            .shadow(radius: 75)
                            .cornerRadius(30)
                            .opacity(0.8)
                            .shadow(color: Color("MainColor").opacity(0.3), radius: 10, y: 10)
                            .offset(y: 0)
                            .overlay {
                                
                                VStack(alignment: .leading, spacing: 8){
                                    
                                    Text("\(viewModel.totalMonthlyIncome) \(SelectionCurrency.defaultCurrency.rawValue)")
                                        .font(.system(size: 22, weight: .bold, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    Text("Total Income")
                                        .font(.system(size: 16, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    
                                }
                            }
                        
                        VStack{}
                            .frame(width: 150, height: 140)
                            .background(Color("MainColor"))
                            .shadow(radius: 75)
                            .cornerRadius(30)
                            .opacity(0.8)
                            .shadow(color: Color("MainColor").opacity(0.3), radius: 10, y: 10)
                            .offset(y: 0)
                            .overlay {
                                
                                VStack(alignment: .leading, spacing: 8){
                                    
                                    Text("\(viewModel.totalMonthlyIncome - viewModel.totalMonthlySpend) \(SelectionCurrency.defaultCurrency.rawValue)")
                                        .font(.system(size: 22, weight: .bold, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    Text("Balance")
                                        .font(.system(size: 16, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    
                                }
                            }
                        
                        VStack{}
                            .frame(width: 150, height: 140)
                            .background(Color("MainColor"))
                            .shadow(radius: 75)
                            .cornerRadius(30)
                            .opacity(0.8)
                            .shadow(color: Color("MainColor").opacity(0.3), radius: 10, y: 10)
                            .offset(y: 0)
                            .overlay {
                                
                                VStack(alignment: .leading, spacing: 8){
                                    
                                    Text("\(viewModel.totalMonthlySpend) \(SelectionCurrency.defaultCurrency.rawValue)")
                                        .font(.system(size: 22, weight: .bold, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    Text("Total Spending")
                                        .font(.system(size: 16, design: .serif))
                                        .foregroundColor(Color("Text"))
                                    
                                }
                            }
                    }
                    
                }
                .padding(9)
                .animation(.spring(response: 0.8, dampingFraction: 0.8))
                
                Divider()
                
                Group{
                    
                    HStack(spacing: 16){
                        
                        VStack{}
                            .frame(width: 390, height: 60)
                            .background(Color("BackgroundBlocks"))
                            .opacity(0.8)
                            .shadow(radius: 75)
                            .cornerRadius(10)
                            .overlay {
                                
                                HStack{
                                    
                                    HStack(spacing: 4){
                                        
                                        Text("Your total is: ")
                                            .font(.system(size: 16, design: .serif))
                                            .foregroundColor(Color("Text"))
                                        Text("\(viewModel.totalCategorySum) \(SelectionCurrency.defaultCurrency.rawValue)")
                                            .font(.headline).bold().italic()
                                            .foregroundColor(Color("Text"))
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Picker("Select a category", selection: $viewModel.selectCategory) {
                                        ForEach(SelectionCategory.spendCategories, id: \.self) {
                                            Text($0.rawValue)
                                                .tag($0)
                                            
                                        }
                                    }
                                    .accentColor(Color("MainColor"))
                                    .pickerStyle(.menu)
                                    
                                }
                                .padding()
                            }
                    }
                }
                
                Group{
                    
                    VStack{
                        
                        if viewModel.transactionData.isEmpty {
                            
                            Text("No transactions found.")
                            
                        } else {
                            
                            if viewModel.isLoadingTransactions{
                                ProgressView("Processing")
                                    .tint(.orange)
                                    .foregroundColor(.gray)
                                
                            } else {
                                
                                List{
                                    
                                    Section{
                                        
                                        ForEach(viewModel.showAllTransactions ? viewModel.transactionData : viewModel.transactionData.suffix(5)){ transaction in
                                            
                                            HStack(spacing: 20){
                                                
                                                (
                                                    transaction.transactionType == .Spend ? Image(systemName: "cart.fill.badge.minus") : Image(systemName: "banknote.fill")
                                                )
                                                .resizable()
                                                .frame(width: 24.0, height: 26.0)
                                                .foregroundColor(Color("MainColor"))
                                                
                                                VStack(alignment: .leading, spacing: 6){
                                                    
                                                    Text("\(transaction.category.rawValue)")
                                                        .minimumScaleFactor(0.5)
                                                        .font(.headline).bold().italic()
                                                        .foregroundColor(Color("Text"))
                                                    
                                                    Text("\(transaction.timestamp.dateValue().formatted(date: .long, time: .omitted))")
                                                        .font(.subheadline)
                                                        .font(.headline).bold().italic()
                                                        .foregroundColor(Color("Text"))
                                                }
                                                
                                                VStack(spacing: 5){
                                                    
                                                    Text("\(transaction.amount) \(transaction.currency.rawValue)")
                                                        .fixedSize(horizontal: true, vertical: false)
                                                        .font(.headline).bold().italic()
                                                        .foregroundColor(transaction.transactionType == .Spend ? Color.red : Color.green)
                                                        .foregroundColor(Color("Text"))
                                                        .frame(maxWidth: .infinity)
                                                    
                                                }
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
                                        HStack{
                                            
                                            Text("Transactions")
                                                .foregroundColor(Color("Text"))
                                                .font(.headline).bold().italic()
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                self.viewModel.showAllTransactions.toggle()
                                            }) {
                                                Text(viewModel.showAllTransactions ? "Less" : "See all")
                                                    .foregroundColor(Color("MainColor"))
                                            }
                                        }
                                        .padding()
                                    }
                                    .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                                    .headerProminence(.increased)
                                }
                                .scrollContentBackground(.hidden)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .transition(.scale)
                            }
                        }
                    }
                }
                .animation(.spring(response: 0.8, dampingFraction: 0.8))
                
                Spacer()
            }
        }
        .onChange(of: viewModel.selectedMonth) { value in
            self.viewModel.updateMonthlyData(selectedMonth: viewModel.selectedMonth)
        }
        .onChange(of: viewModel.selectCategory) { value in
            self.viewModel.categorySum()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

