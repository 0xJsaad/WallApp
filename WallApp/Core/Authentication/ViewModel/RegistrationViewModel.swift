//
//  RegistrationViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published  var email = ""
    @Published  var password = ""
    @Published  var fullname = ""
    @Published  var username = ""
    
    func createdUser() async throws {
       try await AuthService.shared.createUser(
            withEmail: email,
            password: password, 
            fullname: fullname,
            username: username
       )
    }
}
