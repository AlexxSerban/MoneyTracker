
//  Created by Alex Serban on 11.11.2022.
//

import SwiftUI


struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
   
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 90){
                
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
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
