//
//  ProfileViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/18/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set <AnyCancellable>()
    
    init() {
        setupSuscribers()
    }
    
    
    private func setupSuscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            print("DEBUG: User in view model from combine is \(String(describing: user))")
        }.store(in: &cancellables)
    }
    func reset() {
        self.currentUser = nil
    }
}

