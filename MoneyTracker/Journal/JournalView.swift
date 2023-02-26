//
//  JournalView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI
import Charts

struct JournalView: View {
    
    @ObservedObject var viewModel = JournalViewModel()
    
    init() {
        self.viewModel.fetchTransactions()
        self.viewModel.fetchSpendTransactions()
    }
    
    var body: some View {
        ZStack{
            VStack{
                Picker("", selection: $viewModel.periodSection) {
                    ForEach(JournalViewModel.PeriodSection.allCases, id: \.self) { selection in
                        Text(selection.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Divider()
                
                VStack{
                    Chart {
                        ForEach(viewModel.transactionDataFiltered.sorted(by: { $0.amount > $1.amount })) { transaction in
                            BarMark(
                                x: .value("Period", transaction.timestamp.dateValue(), unit: viewModel.periodSection == .day ? .hour : viewModel.periodSection == .week ? .day : viewModel.periodSection == .month ? .weekOfMonth : .month),
                                y: .value("Amount", transaction.amount)
                            )
                            .cornerRadius(10)
                        }
                    }
                    .frame(height: 190)
                }.padding()
                
                if viewModel.transactionData.isEmpty {
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
                                Text("\(transaction.transactionType.rawValue)")
                                    .font(.headline).bold().italic()
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
                Spacer()
            }
        }
        .onChange(of: viewModel.periodSection) { value in
            self.viewModel.fetchTransactions()
            self.viewModel.fetchSpendTransactions()
        }
    }
}




struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
