//
//  LoginViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/18/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published  var email = ""
    @Published  var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
