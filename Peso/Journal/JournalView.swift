//
//  JournalView.swift
//  Peso
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
            
            Color("Background")
                .ignoresSafeArea(.all)
            
            VStack{
                
                Picker("", selection: $viewModel.periodSection) {
                    
                    ForEach(PeriodSection.allCases, id: \.self) { selection in
                        
                        Text(selection.rawValue)
                            .font(.system(size: 14))
                            .foregroundColor(viewModel.periodSection == selection ? Color("MainColor") : .secondary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color("SecondColor"))
                            .clipShape(Capsule())
                        
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                Divider()
                
                VStack{
                    
                    if viewModel.isLoadingChart {
                        
                        ProgressView("Processing", value: 0, total: 100)
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding()
                        
                    } else {
                        
                        Chart{
                            
                            ForEach(viewModel.transactionDataFiltered.sorted(by: { $0.amount > $1.amount })) { transaction in
                                
                                BarMark(
                                    x: .value("Period", transaction.timestamp.dateValue(),
                                              unit: viewModel.periodSection == .day ? .hour : viewModel.periodSection == .week ? .day : viewModel.periodSection == .month ? .weekOfMonth : .month),
                                    y: .value("Amount", Int(transaction.amount) ?? 0)
                                    
                                )
                                .foregroundStyle(Color("MainColor"))
                                .cornerRadius(10)
                                
                            }
                        }
                        
                        .chartXAxis {
                            
                            AxisMarks(values: .automatic) { _ in
                                AxisValueLabel(centered: true)
                                
                            }
                        }
                        
                        .chartYAxis {
                            
                            AxisMarks(position: .leading, values: .automatic) { value in
                                
                                AxisValueLabel() {
                                    
                                    if let intValue = value.as(Int.self) {
                                        if intValue < 1000 {
                                            Text("\(intValue)")
                                                .font(.body)
                                                .foregroundColor(Color("Text"))
                                        } else {
                                            Text("\(intValue/1000)\(intValue == 0 ? "" : "k")")
                                                .font(.body)
                                                .foregroundColor(Color("Text"))
                                        }
                                    }
                                    
                                }
                            }
                            
                        }
                        .transition(.scale)
                        .frame(minHeight: 200)
                        .padding()
                    }
                }.padding()
                
                VStack {
                    
                    if viewModel.transactionData.isEmpty {
                        Text("No transactions found.")
                            .foregroundColor(Color("Text"))
                    } else {
                        
                        if viewModel.isLoadingTransaction {
                            ProgressView("Processing")
                                .tint(.orange)
                                .foregroundColor(.gray)
                            
                        } else {
                            
                            List{
                                
                                Section{
                                    
                                    ForEach(viewModel.transactionData){ transaction in
                                        
                                        HStack(spacing: 20){
                                            
                                            (
                                                transaction.transactionType == .Spend ?
                                                Image(systemName: "cart.fill.badge.minus") :
                                                    Image(systemName: "banknote")
                                            )
                                            .resizable()
                                            .frame(width: 24.0, height: 26.0)
                                            .foregroundColor(Color("MainColor"))
                                            
                                            VStack(alignment: .leading, spacing: 5){
                                                
                                                Text("\(transaction.category.rawValue)")
                                                    .minimumScaleFactor(0.5)
                                                    .font(.headline).bold().italic()
                                                    .foregroundColor(Color("Text"))
                                                
                                                Text("\(transaction.timestamp.dateValue().formatted(date: .long , time: .omitted))")
                                                    .font(.subheadline)
                                                    .font(.headline).bold().italic()
                                                    .foregroundColor(Color("Text"))
                                                
                                            }
                                            
                                            VStack( spacing: 5){
                                                
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
                                    .onDelete(perform: { indexSet in
                                        viewModel.deleteTransactionJournalView(at: indexSet)
                                    })
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
                                    
                                    Text("Transactions")
                                        .foregroundColor(Color("Text"))
                                    
                                }
                                .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .headerProminence(.increased)
                                
                            }
                            .scrollContentBackground(.hidden)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            
                        }
                    }
                    
                    Spacer()
                }
                
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
