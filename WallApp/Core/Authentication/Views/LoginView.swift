//
//  LoginView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var navigateToFeed = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("WallApp app-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()
                
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(WallAppTextFieldModifiers())
                    
                    SecureField("Enter your password", text: $viewModel.password)
                        .modifier(WallAppTextFieldModifiers())
                }
                
                NavigationLink {
                    Text("Forgot password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                        .padding(.trailing, 28)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
                // Anonymous login
                if AuthService.shared.isUserAnonymous {
                    Button {
                        Task { try await viewModel.login() }
                    } label: {
                        Text("Login")
                            .modifier(WallAppButtonModifier())
                    }
                    .padding(.top)
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Sign Up")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.primary)
                        .font(.footnote)
                    }
                    .padding(.vertical, 16)
                } else {
                    Button {
                        Task {
                            do {
                                try await AuthService.shared.signInAnonymously()
                                // No dismissal of the view for anonymous users
                            } catch {
                                // Handle the error
                            }
                        }
                    } label: {
                        Text("Stay Anonymously")
                            .modifier(AnonymousLoginButton())
                    }
                    
                    // Regular login
                    Button {
                        Task {
                            do {
                                try await viewModel.login()
                                navigateToFeed = true  // This will trigger navigation to FeedView
                            } catch {
                                // Handle the error
                            }
                        }
                    } label: {
                        Text("Login")
                            .modifier(WallAppButtonModifier())
                    }
                    
                    // Hidden NavigationLink to the FeedView
                    NavigationLink("", destination: FeedView(), isActive: $navigateToFeed)
                        .hidden()
                    
                    Spacer()
                    
                    Divider()
                    
                    NavigationLink {
                        RegistrationView()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        HStack(spacing: 3) {
                            Text("Don't have an account?")
                            Text("Sign Up")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.primary)
                        .font(.footnote)
                    }
                    .padding(.vertical, 16)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
