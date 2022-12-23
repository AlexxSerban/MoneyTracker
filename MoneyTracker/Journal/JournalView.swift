//
//  JournalView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI

struct JournalView: View {
    
    @StateObject var viewModel = JournalViewModel()
    
    var body: some View {
        VStack{
            Picker("", selection: $viewModel.segmentationSelection) {
                ForEach(JournalViewModel.PeriodSection.allCases, id: \.self) { selection in
                    Text(selection.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
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
        .onChange(of: viewModel.segmentationSelection) { value in
            self.viewModel.fetchTransactions()
        }
        .onAppear() {
            self.viewModel.fetchTransactions()

        }
    }
}




struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
