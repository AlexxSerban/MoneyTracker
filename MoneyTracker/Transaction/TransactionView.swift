//
//  TransactionView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI

struct TransactionView: View {
    
    @ObservedObject var viewModel = TransactionViewModel()
    @Binding var showSheet : Bool
    
    
    var body: some View {
        
        VStack(spacing: 30){
            
            Text("Transaction")
            
            ZStack{
                VStack(alignment:.leading){
                    HStack{
                        Picker("Select a currency", selection: $viewModel.selection) {
                            ForEach(viewModel.currency, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        TextField("0", text: $viewModel.amount)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(Color.blue)
                    }
                    HStack{
                        Image(systemName: "folder.circle.fill")
                        Text("Category")
                        Picker("Select a category", selection: $viewModel.selectionCategory) {
                            ForEach(viewModel.category, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    HStack{
                        Text("How do you pay?")
                        Picker("Select a category", selection: $viewModel.selectionPay) {
                            ForEach(viewModel.howIPay, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    DatePicker(selection: $viewModel.date, displayedComponents: .date, label: { Text("Enter date") })
                }
            }
            .padding()
            
            Button {
                showSheet.toggle()
            } label: {
                Text("Back")
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
