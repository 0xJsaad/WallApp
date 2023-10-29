//
//  ContentViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/18/23.
//

import Foundation
import Combine
import FirebaseAuth


class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedTab: Int = 0
    var isUserAnonymous: Bool {
           return userSession?.isAnonymous ?? true
       }

    func checkEmailVerification() {
        guard let user = Auth.auth().currentUser else { return }  // <-- use Auth.auth().currentUser
        user.reload { error in
            if let error = error {
                print("Failed to reload user: \(error.localizedDescription)")
                return
            }
            
            if user.isEmailVerified {
                self.userSession = user
            } else {
                // Optionally: Log out the user or show a prompt that they need to verify their email
                self.userSession = nil
            }
        }
    }


    
    init() {
        setupSuscribers()
    }
    
    private func setupSuscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
