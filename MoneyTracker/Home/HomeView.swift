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
    
    var body: some View {
        ZStack{
            VStack(spacing: 26) {
                Text("Spending")
                    .font(.headline).bold().italic()
                
                HStack(alignment: .firstTextBaseline, spacing: 16){
                    Text("Balance")
                        .font(.headline).bold().italic()
                    Text("\(viewModel.totalIncome - viewModel.totalSpend)$")
                        .font(.headline).bold().italic()
                }
                
                HStack(spacing: 25){
                    VStack(alignment: .leading, spacing: 15){
                        Text("Total Income")
                            .font(.headline).bold().italic()
                        Text("\(viewModel.totalIncome)$")
                            .font(.headline).bold().italic()
                    }
                    VStack(alignment: .leading, spacing: 15){
                        Text("Total Spending")
                            .font(.headline).bold().italic()
                        Text("\(viewModel.totalSpend)$")
                            .font(.headline).bold().italic()
                    }
                }
                Spacer()
                if viewModel.transactionData.isEmpty {
                    Spacer()
                    Text("No transactions found.")
                } else {
                    List(viewModel.transactionData){ transaction in
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
        .onAppear() {
            self.viewModel.getLastTransactions()
            self.viewModel.calculateMonthlyIncome()
            self.viewModel.calculateMonthlySpend()
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



 
