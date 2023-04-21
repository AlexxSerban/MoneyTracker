//
//  SplashScreenView.swift
//  Peso
//
//  Created by Alex Serban on 21.03.2023.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        
        ZStack{
            
            Color("BackgroundSplashScreen")
                .ignoresSafeArea(.all)
            
            VStack{
                
                Image("SplashScreen")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(rotationAngle))
                    .animation(Animation.linear(duration: 6).repeatForever(autoreverses: false))
                    .onAppear {
                        rotationAngle = 360
                    }
                
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
