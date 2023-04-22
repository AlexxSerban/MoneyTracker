//
//  Term&CondView.swift
//  Peso
//
//  Created by Alex Serban on 22.04.2023.
//

import SwiftUI

struct Term_CondView: View {
    
    @Binding var showTermCond : Bool
    
    var body: some View {
        ZStack{
            
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                HStack{
                    Spacer()
                    
                    Button {
                        showTermCond = false
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .foregroundColor(Color("SecondColor"))
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                     
                            Text("Terms and Conditions")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                            Text("Welcome to Peso - Money Tracker! By using our mobile application, you agree to be bound by the following terms and conditions. If you disagree with any part of these terms and conditions, please do not use our application.")
                        
                            Text("Peso - Money Tracker is designed to help you track your personal finances. By using our application, you agree to use it solely for lawful and personal purposes. You may not use our application for any commercial or illegal purposes.")
                        
                            Text("User Content")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("MainColor"))
                        
                            Text("You are solely responsible for any content you upload or submit to Peso - Money Tracker, including but not limited to financial information, personal information, comments, and feedback. By uploading or submitting content, you grant us a non-exclusive, worldwide, royalty-free, perpetual, irrevocable, and sublicensable license to use, modify, reproduce, distribute, and display such content in connection with our application and business.")
                        
                            Text("Privacy")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(Color("MainColor"))
                        
                            Text("We respect your privacy and are committed to protecting it. Our Privacy Policy governs the collection, use, and disclosure of your personal information. By using our application, you agree to the terms of our Privacy Policy.")
                        
                            VStack(alignment: .leading, spacing: 20){
                                Text("Intellectual Property")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                                Text("The content and design of Peso - Money Tracker, including but not limited to text, graphics, logos, button icons, images, and software, are the property of Peso - Money Tracker or its licensors and are protected by copyright, trademark, and other intellectual property laws. You may not use, copy, reproduce, modify, or distribute any part of our application without our prior written consent.")
                            
                                Text("Disclaimers and Limitations of Liability")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                                Text("Peso - Money Tracker is provided on an (as is) and (as available) basis. We do not guarantee that our application will be uninterrupted, error-free, or free from viruses or other harmful components. To the fullest extent permitted by law, we disclaim all warranties, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, and non-infringement. In no event shall we be liable for any direct, indirect, incidental, special, consequential, or punitive damages arising out of or in connection with the use or inability to use our application.")
                            
                                Text("Indemnification")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                                Text("You agree to indemnify and hold Peso - Money Tracker, its affiliates, officers, directors, agents, and employees harmless from any claim or demand, including reasonable attorneys' fees, made by any third party due to or arising out of your use of our application, your violation of these Terms and Conditions, or your violation of any rights of another.")
                            
                                Text("Changes to Terms and Conditions")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                                Text("We reserve the right to modify or replace these Terms and Conditions at any time. Your continued use of Peso - Money Tracker after any such changes constitutes your acceptance of the new Terms and Conditions.")
                            
                                Text("Contact Us")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(Color("MainColor"))
                            
                                Text("If you have any questions or comments about these Terms and Conditions, please contact us at pesomoneytracker@gmail.com .")
                            }
                        
                    }.padding()
                }
            }.padding()
        }
    }
}

struct Term_CondView_Previews: PreviewProvider {
    static var previews: some View {
        Term_CondView(showTermCond: .constant(true))
    }
}
