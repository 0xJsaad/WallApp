//
//  AnonymusSignIn.swift
//  WallApp
//
//  Created by 0xJs on 10/19/23.
//
import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
        
    func signInAnonymous() async throws {
        let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        let user = User(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }

}

