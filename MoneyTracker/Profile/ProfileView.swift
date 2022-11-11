
//  Created by Alex Serban on 11.11.2022.
//

import SwiftUI


struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewModel()
    
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 32){
                Text("User Profile")
                    .font(.system(size: 18, weight: .bold, design: .serif))
                    .foregroundColor(Color.blue)
                
                HStack(spacing: 12){
                    Text("Name:")
                    Text("\(viewModel.userData.name)")
                }
                HStack(spacing: 12){
                    Text("Phone Number:")
                    Text("\(viewModel.userData.phoneNumber)")
                }
                HStack(spacing: 12){
                    Text("Country:")
                    Text("\(viewModel.userData.country)")
                }
                
            }
            .padding()
            .onAppear() {
                self.viewModel.getData()
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
