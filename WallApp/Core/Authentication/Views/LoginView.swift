//
//  LoginView.swift
//  WallApp
//
//  Created by 0xJs on 10/16/23.
//
import SwiftUI

struct LoginView: View {
    @State var presentedFromAnonymousView: Bool = false
    @State private var navigateToFeed = false
    @StateObject var viewModel = LoginViewModel()
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
                .padding(.vertical)
               
                
                // MARK: Anonymous login
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
                    
                    // MARK: Regular login
                    Button {
                        Task {
                            do {
                                try await viewModel.login()
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
            .padding()
            .offset(y: presentedFromAnonymousView ? -100 : 0)
        }
    }
}

#Preview {
    LoginView()
}
