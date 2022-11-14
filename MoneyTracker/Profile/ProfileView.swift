
//  Created by Alex Serban on 11.11.2022.
//

import SwiftUI


struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 32){
                Text("User Profile")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundColor(Color.blue)
                
                Text("Name: \(viewModel.userData.name)")
                Text("Phone Number: \(viewModel.userData.phoneNumber)")
                Text("Country: \(viewModel.userData.country)")
            }
        }
        .onAppear() {
            print("A mers onAppear in NavigationStack")
            self.viewModel.getData()
        }
    }
        
    
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
