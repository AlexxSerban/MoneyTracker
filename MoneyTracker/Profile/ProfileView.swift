
//  Created by Alex Serban on 11.11.2022.
//

import SwiftUI
import PhotosUI


struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    
    var body: some View {
        
        
        NavigationStack{
            
            ZStack{
                
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    
                    HStack {
                        
                        Text("Account")
                            .font(.system(size: 34, weight: .bold, design: .serif))
                            .foregroundColor(Color("Text"))
                        
                        Spacer()
                        
                        PhotosPicker(
                            
                            selection: $viewModel.selectedItems,
                            maxSelectionCount: 1,
                            matching: .images
                            
                        ) {
                            
                            VStack{
                                
                                if viewModel.isLoadingPhoto {
                                    
                                    ProgressView("Processing")
                                        .tint(.orange)
                                        .foregroundColor(.gray)
                                    
                                } else {
                                    
                                    if let data = viewModel.data, let uiimage = UIImage(data: data) {
                                        Image(uiImage: uiimage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 90, height: 90)
                                            .clipShape(Circle())
                                            .shadow(radius: 10)
                                        
                                    } else {
                                        
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .cornerRadius(50)
                                            .padding(.all, 4)
                                            .frame(width: 90, height: 90)
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .shadow(radius: 10)
                                            .overlay(Circle().stroke(Color("MainColor"), lineWidth: 5))
                                        
                                    }
                                }
                            }
                        }
                    }.padding()
                    
                    
                    
                    VStack(spacing: 20){
                        
                        
                        
                        VStack(spacing: 20) {
                            
                            Form {
                                
                                if viewModel.userInfo {
                                    
                                    if viewModel.isLoadingInfo {
                                        
                                        ProgressView("Processing", value: 0, total: 100)
                                            .progressViewStyle(LinearProgressViewStyle())
                                            .padding()
                                        
                                    } else {
                                        
                                        Section(
                                            header:
                                                
                                                HStack{
                                                    
                                                    Text("Personal Information")
                                                    
                                                    Spacer()
                                                    
                                                    Button { viewModel.userInfo = false }
                                                label: {
                                                    Text("Edit")
                                                        .foregroundColor(Color("MainColor"))
                                                }
                                                }
                                            
                                        ){
                                            
                                            Text("Name: \(viewModel.userData.name)")
                                                .font(.system(size: 16, design: .serif))
                                                .foregroundColor(Color("Text"))
                                            
                                            Text("Phone number: \(viewModel.userData.phoneNumber)")
                                                .font(.system(size: 16, design: .serif))
                                                .foregroundColor(Color("Text"))
                                            
                                            Text("Country: \(viewModel.userData.country)")
                                                .font(.system(size: 16, design: .serif))
                                                .foregroundColor(Color("Text"))
                                            
                                        }
                                    }
                                    
                                } else {
                                    
                                    Section(header:
                                            
                                            HStack{
                                                
                                                Text("Personal Information")
                                                
                                                Spacer()
                                                
                                                Button {
                                                    
                                                    self.viewModel.addProfileInfo()
                                                    viewModel.userInfo = true
                                                    
                                                } label: {
                                                    
                                                    Text("Submit")
                                                        .foregroundColor(Color("MainColor"))
                                                    
                                                } })
                                    
                                    {
                                        
                                        TextField("", text: $viewModel.userData.name, prompt: Text("Name").foregroundColor(Color("Text")))
                                            .font(.system(size: 16, design: .serif))
                                            .foregroundColor(Color("Text"))
                                        
                                        TextField("", text: $viewModel.userData.phoneNumber, prompt: Text("Phone number").foregroundColor(Color("Text")))
                                            .font(.system(size: 16, design: .serif))
                                            .foregroundColor(Color("Text"))
                                        
                                        TextField("", text: $viewModel.userData.country, prompt: Text("Country").foregroundColor(Color("Text")))
                                            .font(.system(size: 16, design: .serif))
                                            .foregroundColor(Color("Text"))
                                        
                                    }
                                }
                                
                                Section(header: Text("Actions")) {
                                    
                                    HStack{
                                        
                                        Text("Select your currency: ")
                                            .font(.system(size: 16, design: .serif))
                                            .foregroundColor(Color("Text"))
                                        
                                       
                                        
                                        Picker("", selection: $viewModel.selectedCurrency) {
                                            ForEach(SelectionCurrency.allCases) { currency in
                                                Text(currency.rawValue).tag(currency)
                                            }
                                        }
                                        .accentColor(Color("MainColor"))
                                        .pickerStyle(MenuPickerStyle())
                                        .onAppear {
                                            
                                            viewModel.selectedCurrency = viewModel.transactionData.currency
                                            
                                        }
                                       
                                    }
                                    
                                    
                                    
                                    Button(action: {
                                        
                                        viewModel.isSignOutActionSheet = true
                                        
                                    }) {
                                        
                                        Text("SignOut")
                                            .font(.system(size: 16, design: .serif))
                                            .foregroundColor(Color.red)
                                            
                                        
                                    }
                                    .actionSheet(isPresented: $viewModel.isSignOutActionSheet) {
                                        ActionSheet(title: Text("Are you sure you want to SignOut?"), buttons: [
                                            .destructive(Text("Sure")) {
                                                self.viewModel.signOutUser()
                                            },
                                            .cancel()
                                        ])
                                    }
                                    
                                    Button(action: {
                                        
                                        viewModel.isDeleteActionSheet = true
                                        
                                    }) {
                                        
                                        Text("Delete Acount")
                                            .font(.system(size: 16, design: .serif))
                                            .foregroundColor(Color.gray)
                                        
                                    }
                                    .actionSheet(isPresented: $viewModel.isDeleteActionSheet) {
                                        ActionSheet(title: Text("Are you sure you want to delete this account?"), buttons: [
                                            .destructive(Text("Sure")) {
                                                self.viewModel.deleteUser()
                                            },
                                            .cancel()
                                        ])
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .onChange(of: viewModel.selectedCurrency) { value in
            viewModel.transactionData.setCurrency(to: value)
        }
        
        .onAppear() {
                
                self.viewModel.getUserData()
                self.viewModel.loadPhoto()
                self.viewModel.downloadImageFromFirebaseStorage()
                self.viewModel.selectedCurrency = self.viewModel.transactionData.currency
            
        }
        .onChange(of: viewModel.selectedItems) { item in
            
            self.viewModel.loadPhoto()
            
        }
        .onChange(of: viewModel.selectedCurrency) { value in
            viewModel.transactionData.setCurrency(to: value)
            self.viewModel.selectedCurrency = self.viewModel.transactionData.currency
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
