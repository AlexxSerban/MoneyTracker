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
            VStack {
                Text("Total Spending")
                    .font(.headline).bold().italic()
                Spacer()
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
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .onAppear() {
            self.viewModel.getLastTransactions()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



