//
//  TabMeniuView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI

struct TabMeniuView: View {
    
    @ObservedObject var transactionViewModel = TransactionViewModel()
    
   
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1
    @State var showSheet: Bool = false
    
    
    var body: some View {
        TabView(selection: $selectedItem) {
            HomeView()
                .tabItem {
                    Image(systemName: "house.circle.fill")
                    Text("Home")
                }
                .tag(1)
            
            JournalView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Transactions")
                }.tag(2)
            
           Text("")
               .tabItem {
                 Image(systemName: "plus.circle.fill")
                }.tag(3)
               
            
            Text("Something")
                .tabItem {
                    Image(systemName: "command.circle.fill")
                    Text("Something")
                }.tag(4)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }.tag(5)
            
            
        }
        .onChange(of: selectedItem) {    // SwiftUI 2.0 track changes
                        if 3 == selectedItem {
                        self.showSheet = true
                            print("A mers")
                        } else {
                            self.oldSelectedItem = $0
                        }
                    }
                .sheet(isPresented: $showSheet, onDismiss: {
                        self.selectedItem = self.oldSelectedItem
                    }) {
                    TransactionView()
                }
        

        
    }
}

struct TabMeniuView_Previews: PreviewProvider {
    static var previews: some View {
        TabMeniuView()
    }
}
