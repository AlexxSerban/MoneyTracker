//
//  UserInfoView.swift
//  MoneyTracker
//
//  Created by Alex Serban on 10.11.2022.
//

import SwiftUI

struct UserInfoView: View {
    
    @ObservedObject var viewModel: UserInfoViewModel
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                
                VStack(spacing: 12){
                    Text("Enter your info")
                   
                    Group{
                        TextField("Name", text: $viewModel.userData.name)
                            .keyboardType(.emailAddress)
                        TextField("Phone number", text: $viewModel.userData.phoneNumber)
                            .keyboardType(.emailAddress)
                        TextField("Country", text: $viewModel.userData.country)
                            .keyboardType(.emailAddress)
                    }
                    .textInputAutocapitalization(.never)
                    
                    Button {
                        viewModel.addProfileInfo()
                    } label: {
                       Text("Submit")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                }.padding()
            }
        }
        .navigationDestination(isPresented: $viewModel.isSuccessful) {
            Text("TODO - Everything worked!")
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(viewModel: UserInfoViewModel())
    }
}
