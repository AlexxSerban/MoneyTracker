//
//  TransactionView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI

struct TransactionView: View {
    
    @Binding var showSheet : Bool
    @StateObject var viewModel = TransactionViewModel(showSheet: true)
    
    var body: some View {
        
        VStack(spacing: 30){
            
            Text("Transaction")
            
            ZStack{
                VStack(alignment:.leading){
                    
                    HStack{
                        Picker("Select a currency", selection: $viewModel.transactionData.currency) {
                            ForEach(TransactionData.SelectionCurrency.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        TextField("0", text: $viewModel.transactionData.amount)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(Color.blue)
                    }
                    HStack{
                        Image(systemName: "folder.circle.fill")
                        Text("Category")
                        Picker("Select a category", selection: $viewModel.transactionData.category) {
                            ForEach(TransactionData.SelectionCategory.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    HStack{
                        Text("How do you pay?")
                        Picker("Select a category", selection: $viewModel.transactionData.paymentMethod) {
                            ForEach(TransactionData.SelectionPay.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    DatePicker(selection: $viewModel.transactionData.date, label: { Text("Enter date") })
                }
            }
            .padding()
            
            Button {
                showSheet = false
                viewModel.addTransactionInfo(amount: viewModel.transactionData.amount, currency: viewModel.transactionData.currency, category: viewModel.transactionData.category, paymentMethod: viewModel.transactionData.paymentMethod, date: viewModel.transactionData.date)
                if showSheet == false{
                    print("showSheet s a setat pe false")
                }
                
            } label: {
                Text("Save")
            }
            .font(.system(size: 18, weight: .bold, design: .serif))
            .foregroundColor(Color.orange)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(showSheet: .constant(true))
    }
}
