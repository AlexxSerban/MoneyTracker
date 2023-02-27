//
//  HistoryView.swift
//  MoneyTracker
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
        ZStack(alignment: .center){
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
                    .background(.blue)
                }
                
                Group {
                    ScrollView(.horizontal) {
                        HStack() {
                            ForEach(viewModel.months, id: \.self) { item in
                                Text(item)
                                    .foregroundColor((item == viewModel.selectedMonth) ? .blue:.green)
                                    .padding(.all, 12.0)
                                    .onTapGesture {
                                        self.viewModel.setMonthPeriod(selectedMonth: item)
                                    }
                            }
                        }
                    }
                }
                Divider()
                
                HStack{
                    VStack{
                        Text("Total Income")
                            .font(.headline).bold().italic()
                        Text("\(viewModel.totalMonthlyIncome)$")
                            .font(.headline).bold().italic()
                    }
                    .pickerStyle(.menu)
                    
                    
                    VStack{
                        Text("Balance")
                            .font(.headline).bold().italic()
                        Text("\(viewModel.totalMonthlyIncome - viewModel.totalMonthlySpend)$")
                            .font(.headline).bold().italic()
                    }
                    
                    VStack{
                        Text("Total Spending")
                            .font(.headline).bold().italic()
                        Text("\(viewModel.totalMonthlySpend)$")
                            .font(.headline).bold().italic()
                    }
                }
                Divider()
                
                Group{
                    HStack(spacing: 16){
                        Picker("Select a category", selection: $viewModel.selectCategory) {
                            ForEach(SelectionCategory.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        VStack{
                            Text("\(viewModel.selectCategory.rawValue)")
                            Text("\(viewModel.totalCategorySum)")
                        }
                    }
                    .padding()
                }
                Divider()
                
                
                
                Group{
                    VStack(spacing: 3){
                        HStack{
                            Spacer()
                            Button(action: {
                                self.viewModel.showAllTransactions.toggle()
                            }) {
                                Text(viewModel.showAllTransactions ? "Less" : "Show all")
                            }
                        }.padding()
                        
                        if viewModel.transactionData.isEmpty {
                            Text("No transactions found.")
                        } else {
                            List{
                                ForEach(viewModel.showAllTransactions ? viewModel.transactionData : viewModel.transactionData.suffix(5)){ transaction in
                                    HStack(spacing: 15){
                                        Image(systemName: "cart.fill")
                                        VStack(alignment: .leading, spacing: 5){
                                            Text("\(transaction.category.rawValue)")
                                                .minimumScaleFactor(0.5)
                                            Text("\(transaction.paymentMethod.rawValue)")
                                                .minimumScaleFactor(0.5)
                                        }
                                        Text("\(transaction.timestamp.dateValue().formatted(date: .numeric, time: .omitted))")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        Text("\(transaction.amount)")
                                            .font(.headline).bold().italic()
                                        Text("\(transaction.currency.rawValue)")
                                            .font(.headline).bold().italic()
                                        Text("\(transaction.transactionType.rawValue)")
                                            .font(.headline).bold().italic()
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                    }
                    Divider()
                }
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

