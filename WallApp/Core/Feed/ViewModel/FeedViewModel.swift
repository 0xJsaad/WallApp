//
//  FeedViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/22/23.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var walls = [Wall]()
    
    init() {
        Task { try await fetchWalls() }
    }
    
    func fetchWalls() async throws {
        self.walls = try await WallService.fetchWall()
        try await fetchUserDataforWalls()
    }
    
    private func fetchUserDataforWalls() async throws {
        for i in 0 ..< walls.count {
            let wall = walls[i]
            let ownerUid = wall.ownerUid
            let wallUser = try await UserService.fetchUser(withUid: ownerUid)
            
            walls[i].user = wallUser
        }
    }
}
