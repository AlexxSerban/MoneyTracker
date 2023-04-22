//
//  PrivacyPolicyView.swift
//  Peso
//
//  Created by Alex Serban on 22.04.2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
    
    @Binding var showPrivacyPolicy : Bool
    
    var body: some View {
        ZStack{
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    Spacer()
                    
                    Button {
                        showPrivacyPolicy = false
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .foregroundColor(Color("SecondColor"))
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                       
                                Text("Privacy Policy")
                                    .font(.system(size: 34, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("MainColor"))
                              
                            
                            Text("At Peso - Money Tracker, accessible from the App Store, one of our main priorities is the privacy of our users. This Privacy Policy document contains types of information that is collected and recorded by Peso - Money Tracker and how we use it.")
                            
                            Text("If you choose to use Peso - Money Tracker, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.")
                            
                            Text("Information Collection and Use")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                            Text("For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to your name, email address, and financial information. The information that we collect will be used to contact or identify you.")
                            
                            Text(" We may also collect non-personally identifiable information that your device sends whenever you use our Service. This may include information such as your device's Internet Protocol (IP) address, device name, operating system version, app version, the time and date of your use of the Service, and other statistics.")
                        
                        
                        VStack(alignment: .leading, spacing: 20){
                            Text("Log Data")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                            Text("We want to inform you that whenever you use our Service, in case of an error in the app, we collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device's Internet Protocol (IP) address, device name, operating system version, app version, the time and date of your use of the Service, and other statistics.")
                            
                            Text("Cookies")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                            Text("Cookies are files with small amount of data that is commonly used as an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your device's internal memory. This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device.")
                            
                            Text("Service Providers")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                            Text("We may employ third-party companies and individuals due to the following reasons: To facilitate our Service; To provide the Service on our behalf; To perform Service-related services; or To assist us in analyzing how our Service is used. We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose. ")
                            
                            Text("Security")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                            Text("We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.")
                        }
                        
                        
                    }.padding()
                }
            }.padding()
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView(showPrivacyPolicy: .constant(true))
    }
}

