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
    @Published var likedWalls = [Wall]()
    private let service = WallService()
    let user: User
    
    init(user: User) {
        self.user = user
        Task {
            do {
                try await fetchUserWalls()
            } catch {
                // Handle error appropriately, e.g., print to console or show to user
                print("Failed to fetch user walls:", error)
            }
        }
    }
    
    func fetchUserWalls() async throws {
        var walls = try await WallService.fetchUserWalls(uid: user.id) // Use class name for static methods
        
        for i in 0 ..< walls.count {
            walls[i].user = self.user
        }
        
        self.walls = walls
    }
}
