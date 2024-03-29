//
//  TabMeniuView.swift
//  Peso
//
//  Created by Alex Serban on 14.11.2022.
//

import SwiftUI

struct TabMenuView: View {
    
    // Selected Item
    @State private var selectedItem = 1
    @State private var oldSelectedItem = 1
    
    // Status
    @State private var showSheet = false
    
    init(){
        
        UITabBar.appearance().backgroundColor = UIColor(Color("BackgroundBlocks"))
    }
    
    var body: some View {
        withAnimation{
            
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
                        Text("Journal")
                    }.tag(2)
                
                Text("")
                    .tabItem {
                        Image(systemName: "plus.circle.fill")
                    }.tag(3)
                
                HistoryView()
                    .tabItem {
                        Image(systemName: "hourglass.circle.fill")
                        Text("History")
                    }.tag(4)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }.tag(5)
                
            }
            .accentColor(Color("MainColor"))
            .onChange(of: selectedItem) {
                
                if 3 == selectedItem {
                    self.showSheet = true
                    print("'showSheet' has worked")
                    
                } else {
                    
                    self.oldSelectedItem = $0
                    
                }
            }
            .sheet(isPresented: $showSheet, onDismiss: {
                self.selectedItem = self.oldSelectedItem
            }) {
                TransactionView(showSheet: $showSheet)
            }
        }
    }
}

struct TabMeniuView_Previews: PreviewProvider {
    static var previews: some View {
        TabMenuView()
    }
}
