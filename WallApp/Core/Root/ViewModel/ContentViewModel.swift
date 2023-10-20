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
    
    init() {
        setupSuscribers()
    }
    
    private func setupSuscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
