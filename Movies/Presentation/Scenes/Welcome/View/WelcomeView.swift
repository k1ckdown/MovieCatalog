//
//  WelcomeView.swift
//  Movies
//
//  Created by Ivan Semenov on 18.10.2023.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.ContentStack.spacing) {
                Image(.amico)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: Constants.AmicoImage.height)
                    .padding(.top, Constants.AmicoImage.topInset)
                
                VStack(spacing: Constants.DescriptionStack.spacing) {
                    Text("WelcomeTitle")
                        .bold()
                        .font(.title2)
                        .multilineTextAlignment(.center)

                    Text("WelcomeBody")
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
                .padding()

                VStack(spacing: Constants.ButtonStack.spacing) {
                    BaseButton(title: "Registration") {
                        
                    }
                    
                    BaseButton(title: "Log In", isProminent: false) {
                        
                    }
                }
                
                Spacer()
            }
            .appBackground()
            .appNavigationTitle()
        }
    }
    
    private enum Constants {
        enum ContentStack {
            static let spacing: CGFloat = 40
        }
        
        enum AmicoImage {
            static let height: CGFloat = 338
            static let topInset: CGFloat = 20
        }
        
        enum DescriptionStack {
            static let spacing: CGFloat = 10
        }
        
        enum ButtonStack {
            static let spacing: CGFloat = 15
        }
    }
}

#Preview {
    WelcomeView()
        .environment(\.locale, .init(identifier: "ru"))
}
