//
//  UserInfoView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 10.11.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    @State var addOk: Bool = false
    
    @ObservedObject var userData = UserData(name: "", phoneNumber: "", country: "")
    @ObservedObject var viewModel: UserInfoViewModel
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                
                VStack(spacing: 12){
                    Text("Enter your info")
                   
                    Group{
                        TextField("Name", text: $userData.name)
                            .keyboardType(.emailAddress)
                        TextField("Phone number", text: $userData.phoneNumber)
                            .keyboardType(.emailAddress)
                        TextField("Country", text: $userData.country)
                            .keyboardType(.emailAddress)
                    }
                    .textInputAutocapitalization(.never)
                    
                    Button {
                        viewModel.addInfoProfile(name: userData.name, phoneNumber: userData.phoneNumber, country: userData.country)
                        
                        addOk = true
                        
                    } label: {
                       Text("Submit")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                }.padding()
            }
        }
        .navigationDestination(isPresented: $addOk) {
            Text("A mers cumetre")
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModel: UserInfoViewModel())
    }
}
