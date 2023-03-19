
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
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [Color("MainColor")], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 440, height: 700)
                    .cornerRadius(150)
                    .rotationEffect(.degrees(90))
                    .offset(x: 120 ,y: -400)
                    
                    
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
                                    .frame(width: 130, height: 130)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                
                            } else {
                                
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .cornerRadius(50)
                                    .padding(.all, 4)
                                    .frame(width: 130, height: 130)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                                
                            }
                        }
                    }
                }
                .offset(y: -260)
                
                HStack{
                    VStack(spacing: 60){
                        
                        if viewModel.userInfo {
                            
                            if viewModel.isLoadingInfo {
                                
                                ProgressView("Processing", value: 0, total: 100)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .padding()
                                
                            } else {
                                
                                VStack(spacing: 20) {
                                    
                                    Group{
                                        
                                        VStack(alignment: .leading, spacing: 8){
                                            
                                           
                                               
                                                Rectangle()
                                                    .frame(width: 380, height: 60)
                                                    .foregroundColor(Color("BackgroundBlocks"))
                                                    .cornerRadius(10)
                                                    .opacity(0.8)
                                                    .overlay {
                                                        HStack(alignment: .firstTextBaseline){
                                                            VStack(spacing: 6){
                                                                
                                                                Text("Name")
                                                                    .font(.system(size: 12, design: .serif))
                                                                    .foregroundColor(Color("Text"))
                                                                
                                                                Text("\(viewModel.userData.name)")
                                                                    .font(.system(size: 14, weight: .bold, design: .serif))
                                                                    .foregroundColor(Color("Text"))
                                                                
                                                            }
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            .padding()
                                                        }
                                                    }
                                            
                                            
                                            
                                               
                                                Rectangle()
                                                    .frame(width: 380, height: 60)
                                                    .foregroundColor(Color("BackgroundBlocks"))
                                                    .cornerRadius(10)
                                                    .opacity(0.8)
                                                    .overlay {
                                                        VStack(alignment: .leading, spacing: 6){
                                                            
                                                            Text("Phone Number")
                                                                .font(.system(size: 12, design: .serif))
                                                                .foregroundColor(Color("Text"))
                                                            Text("\(viewModel.userData.phoneNumber)")
                                                                .font(.system(size: 14, weight: .bold, design: .serif))
                                                                .foregroundColor(Color("Text"))
                                                            
                                                        }
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding()
                                                    }
                                            
                                            
                               
                                               
                                                Rectangle()
                                                    .frame(width: 380, height: 60)
                                                    .foregroundColor(Color("BackgroundBlocks"))
                                                    .cornerRadius(10)
                                                    .opacity(0.8)
                                                    .overlay {
                                                        VStack(alignment: .leading, spacing: 6){
                                                            
                                                            Text("Country")
                                                                .font(.system(size: 12, design: .serif))
                                                                .foregroundColor(Color("Text"))
                                                            Text("\(viewModel.userData.country)")
                                                                .font(.system(size: 14, weight: .bold, design: .serif))
                                                                .foregroundColor(Color("Text"))
                                                            
                                                        }
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding()
                                                    }
                                            
                                        }
                                    }
                                    .padding()
                                    
                                    VStack(alignment: .trailing){
                                        
                                        Button {
                                            viewModel.userInfo = false
                                        } label: {
                                            Text("Edit")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding()
                                                .background(Color("SecondColor"))
                                                .cornerRadius(10)
                                                
                                            
                                        }
                                    }.offset(x: 160, y: -20)
                                }
                                .padding()
                            }
                            
                        } else {
                            
                            VStack(spacing: 20){
                                
                                Group{
                                    
                                    VStack(alignment: .leading){
                                        
                                        VStack(alignment: .leading, spacing: 12){
                                            
                                            Rectangle()
                                                .frame(width: 380, height: 60)
                                                .foregroundColor(Color("BackgroundBlocks"))
                                                .cornerRadius(10)
                                                .opacity(0.8)
                                                .overlay {
                                                    
                                                    HStack(alignment: .firstTextBaseline){
                                                        TextField("", text: $viewModel.userData.name, prompt: Text("Name").foregroundColor(Color("Text")))
                                                            .font(.system(size: 16, weight: .bold, design: .serif))
                                                            .foregroundColor(Color("Text"))
                                                    }
                                                    .padding()
                                                }
                                        
                                            
                                        }
                                        
                                      
                                        VStack(alignment: .leading, spacing: 12){
                                            
                                            Rectangle()
                                                .frame(width: 380, height: 60)
                                                .foregroundColor(Color("BackgroundBlocks"))
                                                .cornerRadius(10)
                                                .opacity(0.8)
                                                .overlay {
                                                    
                                                    HStack(alignment: .firstTextBaseline){
                                                        TextField("", text: $viewModel.userData.phoneNumber, prompt: Text("Phone number").foregroundColor(Color("Text")))
                                                            .font(.system(size: 16, weight: .bold, design: .serif))
                                                            .foregroundColor(Color("Text"))
                                                    }
                                                    .padding()
                                                }
                                            
                                        }
                                        
                                        
                                        VStack(alignment: .leading, spacing: 12){
                                            
                                            Rectangle()
                                                .frame(width: 380, height: 60)
                                                .foregroundColor(Color("BackgroundBlocks"))
                                                .cornerRadius(10)
                                                .opacity(0.8)
                                                .overlay {
                                                    
                                                    HStack(alignment: .firstTextBaseline){
                                                        TextField("", text: $viewModel.userData.country, prompt: Text("Country").foregroundColor(Color("Text")))
                                                            .font(.system(size: 16, weight: .bold, design: .serif))
                                                            .foregroundColor(Color("Text"))
                                                    }
                                                    .padding()
                                                }
                                        }
                                    }
                                }
                                .padding()
                                .textInputAutocapitalization(.never)
                                
                                
                                Button {
                                    
                                    self.viewModel.addProfileInfo()
                                    viewModel.userInfo = true
                                    
                                } label: {
                                    
                                    Text("Submit")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color("SecondColor"))
                                        .cornerRadius(10)
                                    
                                }
                                .offset(x: 145, y: -20)
                            }
                            .padding()
                        }
                    }
                }
                .offset(y: 60)
                
                
                
                VStack {
                    
                    Rectangle()
                        .frame(width: 380, height: 60)
                        .foregroundColor(Color("BackgroundBlocks"))
                        .cornerRadius(10)
                        .opacity(0.8)
                        .overlay {
                            
                            HStack{
                                
                                Picker("Select Currency", selection: $viewModel.selectedCurrency) {
                                           ForEach(SelectionCurrency.allCases) { currency in
                                               Text(currency.rawValue).tag(currency)
                                           }
                                       }
                                       .pickerStyle(MenuPickerStyle())
                                       .onAppear {
                                           viewModel.selectedCurrency = viewModel.transactionData.currency
                                       }
                                       
                                       
                                Text("Selected currency: \(viewModel.transactionData.currency.rawValue)")
                                    .font(.system(size: 16, weight: .bold, design: .serif))
                                    .foregroundColor(Color("Text"))
                                   }
                                
                            }
                        }
                    
                    
                .offset(x: -10, y: 240)
                
                VStack{
                    
                    HStack(spacing: 60){
                        
                        Button(action: {
                            
                            viewModel.isSignOutActionSheet = true
                            
                        }) {
                            
                            Text("SignOut")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color("SecondColor"))
                                .cornerRadius(10)
                            
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
                                .font(.headline)
                                .foregroundColor(Color("SecondColor"))
                                .padding()
                                .background(Color("BackgroundBlocks"))
                                .cornerRadius(10)
                            
                        }
                        .actionSheet(isPresented: $viewModel.isDeleteActionSheet) {
                            ActionSheet(title: Text("Are you sure you want to delete this item?"), buttons: [
                                .destructive(Text("Sure")) {
                                    self.viewModel.deleteUser()
                                },
                                .cancel()
                            ])
                        }
                    }
                }
                .offset(y: 320)
            }
            .onChange(of: viewModel.selectedCurrency) { value in
                viewModel.transactionData.setCurrency(to: value)
            }
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
