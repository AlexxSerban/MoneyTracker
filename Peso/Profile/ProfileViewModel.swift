
//  UserProfileViewModel.swift
//  Peso
//
//  Created by Alex Serban on 11.11.2022.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    
    // Dependencies
    let authClient: AuthClient
    let userRepository: UserRepository
    
    @Published var data: Data?
    @Published var photoURL: String = ""
    
    // Status
    @Published var isLoadingPhoto: Bool = false
    @Published var isLoadingInfo: Bool = false
    @Published var isDeleteActionSheet: Bool = false
    @Published var isSignOutActionSheet: Bool = false
    @Published var userInfo: Bool = true {
        didSet {
            UserDefaults.standard.set(userInfo, forKey: "userInfo")
        }
    }
    
    // User Data
    @Published var transactionData = TransactionData()
    @Published var userData = UserData()
    @Published var selectedCurrency: SelectionCurrency
    @Published var selectedItems: [PhotosPickerItem] = []
    
    init(
        authClient: AuthClient = DIContainer.shared.resolve(type: AuthClient.self),
        userRepository: UserRepository = DIContainer.shared.resolve(type: UserRepository.self)
        
    ) {
        self.authClient = authClient
        self.userRepository = userRepository
        self.transactionData = TransactionData()
        self.selectedCurrency = TransactionData().currency
    }
    
    @MainActor
    func addProfileInfo() {
        Task {
            do {
                try await userRepository.addUser(userData: userData)
                await MainActor.run {
                    userInfo = true
                    print("The 'Add User Profile Info' function worked")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getUserData() {
        Task {
            do {
                isLoadingInfo = true
                self.userData = try await userRepository.getUser()
                userInfo = UserDefaults.standard.bool(forKey: "userInfo")
                await MainActor.run {
                    isLoadingInfo = false
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }
    }
    
    @MainActor
    func signOutUser() {
        Task{
            do {
                let _ = try await authClient.signOut()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func deleteUser() {
        Task{
            do {
                let _ = try await authClient.deleteAccount()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func loadPhoto() {
        guard let item = selectedItems.first else {
            return
        }
        item.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data {
                    self.data = data
                    self.uploadImageToFirebaseStorage()
                } else {
                    print("Data is nil")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func uploadImageToFirebaseStorage() {
        
        // Create a root reference
        let storageRef = Storage.storage().reference()
        // Get the user ID
        guard let userId = authClient.getUserId() else {
            return
        }
        // Create a reference to the file you want to upload
        let photoRef = storageRef.child("\(userId)/profilePicture/profilePhoto.jpg")
        
        guard let imageData = data else {
            print("There is no image data available.")
            return
        }
        
        // Upload the file to the path "\(userId)/profilePicture/profilePhoto.jpg"
        let _ = photoRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("There was an error at uploadTask!")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let _ = metadata.size
            
            photoRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("There was an error at downloadURL!")
                    return
                }
                self.photoURL = downloadURL.absoluteString
                self.downloadImageFromFirebaseStorage()
                print("The downloaded URL is: \(self.photoURL)")
            }
        }
    }
    
    
    @MainActor
    func downloadImageFromFirebaseStorage() {
        isLoadingPhoto = true
        // Get the user ID
        guard let userId = authClient.getUserId() else {
            return
        }
        // Get a reference to the profile picture in Firestore Storage
        let storageRef = Storage.storage().reference().child("\(userId)/profilePicture/profilePhoto.jpg")
        
        // Download the profile image URL
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Could not get the URL of the photo: \(error.localizedDescription)")
                self.isLoadingPhoto = false
            } else if let url = url {
                // Download profile picture data
                let storageRefPhoto = Storage.storage().reference(forURL: url.absoluteString)
                
                storageRefPhoto.getData(maxSize: 10 * 1024 * 1024) { data, error in
                    if let error = error {
                        print("Error downloading the image: \(error.localizedDescription)")
                    } else if let imageData = data {
                        self.data = imageData
                        self.isLoadingPhoto = false
                        
                        print("Downloaded profile photo worked")
                    }
                }
            }
        }
    }
}

