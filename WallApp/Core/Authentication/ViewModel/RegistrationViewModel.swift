//
//  RegistrationViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//

import Foundation

@MainActor
class RegistrationViewModel: ObservableObject {
    @Published  var email = ""
    @Published  var password = ""
    @Published  var fullname = ""
    @Published  var username = ""
    @Published var selectedTab: Int = 0
    @Published var showAlert = false
    
    
    
    func createdUser() async {
        // Check if user is currently anonymous
        if AuthService.shared.isUserAnonymous {
            do {
                try await AuthService.shared.linkAnonymousToEmail(email: email, password: password)
                
                // Then, proceed to upload user data like name and username
                try await AuthService.shared.uploadUserData(withEmail: email, fullname: fullname, username: username, id: AuthService.shared.userSession?.uid ?? "")
                
                // Send email verification after linking anonymous user to email and password
                do {
                    try await AuthService.shared.sendEmailVerificationLink(to: email)
                } catch {
                    print("DEBUG: Error sending verification email to linked user: \(error.localizedDescription)")
                }
            } catch {
                print("DEBUG: Error linking anonymous user: \(error.localizedDescription)")
            }
        } else {
            do {
                try await AuthService.shared.createUser(
                    withEmail: email,
                    password: password,
                    fullname: fullname,
                    username: username
                )
                // Send email verification after user creation
                do {
                    try await AuthService.shared.sendEmailVerificationLink(to: email)
                } catch {
                    print("DEBUG: Error sending verification email: \(error.localizedDescription)")
                }
            } catch {
                print("DEBUG: Error creating user: \(error.localizedDescription)")
            }
        }
    }
}
