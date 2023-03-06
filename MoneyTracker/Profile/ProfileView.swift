
//  Created by Alex Serban on 11.11.2022.
//

import SwiftUI
import PhotosUI


struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 70){
                
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
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                            } else {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .cornerRadius(50)
                                    .padding(.all, 4)
                                    .frame(width: 110, height: 110)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 5))
                            }
                        }
                    }
                }
                
                if viewModel.userInfo {
                    if viewModel.isLoadingInfo {
                        ProgressView("Processing", value: 0, total: 100)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .padding()
                    } else {
                        VStack(spacing: 12) {
                            VStack(alignment: .leading){
                                Text("Name: \(viewModel.userData.name)")
                                Text("Phone Number: \(viewModel.userData.phoneNumber)")
                                Text("Country: \(viewModel.userData.country)")
                            }
                            VStack(alignment: .trailing){
                                Button {
                                    viewModel.userInfo = false
                                } label: {
                                    Text("Edit")
                                }
                            }
                        }
                    }
                } else {
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
                            self.viewModel.addProfileInfo()
                            viewModel.userInfo = true
                        } label: {
                            Text("Submit")
                        }
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.capsule)
                    }.padding()
                }
                
                HStack(spacing: 60){
                    Button(action: {
                        self.viewModel.signOutUser()
                    }) {
                        Text("SignOut")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        self.viewModel.deleteUser()
                    }) {
                        Text("Delete Acount")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .onAppear() {
            self.viewModel.getUserData()
            self.viewModel.loadPhoto()
            self.viewModel.downloadImageFromFirebaseStorage()
        }
        .onChange(of: viewModel.selectedItems) { item in
            self.viewModel.loadPhoto()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
