//
//  UserContentListViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/23/23.
//

import Foundation

@MainActor
class UserContentListViewModel: ObservableObject {
    @Published var walls = [Wall]()
    
    let user: User
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserWalls() }
    }
    
    func fetchUserWalls() async throws {
        var walls = try await WallService.fetchUserWalls(uid: user.id)
        
        for i in 0 ..< walls.count {
            walls[i].user = self.user
        }
        
        self.walls = walls
    }
}
