//
//  AnonymousAccessToTabs.swift
//  WallApp
//
//  Created by 0xJs on 10/18/23.
//
import SwiftUI

struct AnonymousAccessToTabs: View {
    @State private var scaleEffect: CGFloat = 1.0
    @State private var navigateToLogin = false // To control navigation
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "person.fill.questionmark")
                      .resizable()
                      .scaledToFit()
                      .frame(width: 100, height: 100)
                      .foregroundColor(.purple)
                
                Divider().padding(.horizontal)
                
                Text("You're currently having a sneak peek of what's trending as an anonymous user.")
                               .font(.headline)

                Text("Get the most out of WallApp by creating an account!")
                    .font(.subheadline)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.center)

                Divider().padding(.horizontal)
            
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    Button(action: {
                        navigateToLogin = true
                    }) {
                        Text("Sign Up / Log In")
                            .font(.headline)
                            .padding()
                            .background(Color.purple)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
        }
    }
}

#Preview {
    AnonymousAccessToTabs()
}
