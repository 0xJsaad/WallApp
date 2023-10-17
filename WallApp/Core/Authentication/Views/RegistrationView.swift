//
//  RegistrationView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var fullname = ""
    @State private var username = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Image("WallApp app-icon")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding()
            
            VStack {
                TextField("Enter your email", text: $email)
                    .modifier(WallAppTextFieldModifiers())
                
                SecureField("Enter your password", text: $password)
                    .modifier(WallAppTextFieldModifiers())
                
                TextField("Enter your full name", text: $fullname)
                    .modifier(WallAppTextFieldModifiers())
                
                TextField("Enter your username", text: $username)
                    .modifier(WallAppTextFieldModifiers())
            }
            
            Button {
                
            } label: {
                Text("Sign Up")
                    .modifier(WallAppButtonModifier())
            }
            .padding(.vertical)
            
            Spacer()
            
            Divider()
            
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3) {
                    Text("Already have an account?")
                    
                    Text("Sign in")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.primary)
                .font(.footnote)
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    RegistrationView()
}
