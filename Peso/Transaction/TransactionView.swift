//
//  TransactionView.swift
//  Peso
//
//  Created by Alex Serban on 14.11.2022.
//
import UIKit
import SwiftUI
import FirebaseFirestore
import Combine

struct TransactionView: View {
    
    @StateObject var viewModel = TransactionViewModel()
    
    // View Init
    @Binding var showSheet : Bool
    
    var body: some View {
        
        ZStack{
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10){
                
                    HStack{
                        
                        Spacer()
                        
                        Button {
                            showSheet = false
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .foregroundColor(Color("MainColor"))
                        .padding()
                    }
                    .padding()
                    
                    HStack(alignment: .center){
                        Text("Transaction")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .offset(y: -40)
                            .foregroundColor(Color("Text"))
                    }
               
                Spacer()
                    .frame(height: 10)
                
                HStack{
                    
                    VStack(alignment:.leading){
                        
                        VStack{}
                            .padding()
                            .frame(width: 360, height: 350)
                            .background(Color("BackgroundBlocks"), in: RoundedRectangle(cornerRadius: 50, style: .continuous))
                            .shadow(radius: 4)
                            .overlay {
                                
                                VStack(alignment: .leading, spacing: 16){
                                    
                                    HStack(alignment: .center){
                                        TextField("", text: $viewModel.transactionData.amount,
                                                  prompt: Text("Amount ").foregroundColor(Color("Text")))
                                        .font(.system(size: 18, design: .serif))
                                        .accentColor(Color("Text"))
                                        .keyboardType(.numberPad)
                                        
                                        Spacer()
                                    }
                                    
                                    Divider()
                                    
                                    HStack{
                                        
                                        Text("Transaction Type")
                                            .font(.system(size: 18, design: .serif))
                                            .foregroundColor(Color("Text"))
                                        
                                        Spacer()
                                        
                                        Picker("Select a category", selection: $viewModel.transactionData.transactionType) {
                                            ForEach(TransactionType.allCases, id: \.self) {
                                                Text($0.rawValue)
                                                    .tag($0)
                                            }
                                        }
                                        .accentColor(Color.white)
                                        .background(Color("MainColor"))
                                        .opacity(0.8)
                                        .foregroundColor(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: Color("MainColor").opacity(0.3), radius: 10, y: 10)
                                        .pickerStyle(.menu)
                                    }
                                    
                                    Divider()
                                    
                                    HStack{
                                        
                                        Text("Category")
                                            .font(.system(size: 18, design: .serif))
                                            .foregroundColor(Color("Text"))
                                        
                                        Spacer()
                                        
                                        Picker("Select a category", selection: $viewModel.transactionData.category) {
                                            ForEach(viewModel.transactionData.transactionType == .Spend ? SelectionCategory.spendCategories : SelectionCategory.incomeCategories,  id: \.self) {
                                                Text($0.rawValue)
                                                    .tag($0)
                                            }
                                        }
                                        .accentColor(Color.white)
                                        .background(Color("MainColor"))
                                        .opacity(0.8)
                                        .cornerRadius(10)
                                        .shadow(color: Color("MainColor").opacity(0.3), radius: 10, y: 10)
                                        .pickerStyle(.menu)
                                    }
                                    
                                    Divider()
                                    
                                    DatePicker(selection: $viewModel.transactionData.date,
                                               label: {
                                        Text("Enter date")
                                            .font(.system(size: 18, design: .serif))
                                            .foregroundColor(Color("Text"))
                                    })
                                    
                                    
                                }.padding()
                            }
                            .padding()
                    }
                }

                
                Button {
                    viewModel.addTransactionInfo()
                    showSheet = false
                } label: {
                    
                    Circle()
                        .fill(Color("MainColor"))
                        .frame(width: 80, height: 60)
                        .overlay(
                            Image(systemName: "checkmark")
                                .resizable()
                                .padding(10)
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .mask(Circle())
                        )
                    
                }
                .font(.system(size: 18, weight: .bold, design: .serif))
                .foregroundColor(Color.orange)
                .offset(y: -30)
                .padding()
                
            }
        }
        .onTapGesture { UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) }
    }
        
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(showSheet: .constant(true))
    }
}


