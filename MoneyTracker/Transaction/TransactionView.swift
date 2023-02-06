//
//  TransactionView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI
import FirebaseFirestore
import Combine

struct TransactionView: View {
    
    @StateObject var viewModel = TransactionViewModel()
    
    // View Init
    @Binding var showSheet : Bool
    
    var body: some View {
        
        VStack(spacing: 30){
            
            Text("Transaction")
            
            ZStack{
                VStack(alignment:.leading){
                    HStack{
                        Picker("Select a currency", selection: $viewModel.transactionData.currency) {
                            ForEach(SelectionCurrency.allCases, id: \.self) {
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
                            ForEach(SelectionCategory.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    HStack{
                        Text("How do you pay?")
                        Picker("Select a category", selection: $viewModel.transactionData.paymentMethod) {
                            ForEach(SelectionPay.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    DatePicker(selection: $viewModel.transactionData.date, label: { Text("Enter date") })
                    
                    HStack{
                        Text("Transaction Type")
                        Picker("Select a category", selection: $viewModel.transactionData.transactionType) {
                            ForEach(TransactionType.allCases, id: \.self) {
                                Text($0.rawValue)
                                    .tag($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
            }
            .padding()
            
            Button {
                viewModel.addTransactionInfo()
                
                // Closes the sheet
                showSheet = false
            } label: {
                Text("Save")
            }
            .font(.system(size: 18, weight: .bold, design: .serif))
            .foregroundColor(Color.orange)
            
            Button {
                showSheet = false
            } label: {
                Text("Cancel")
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


