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
    @Published var replies = [WallReply]()

    let user: User
    
    init(user: User) {
        self.user = user
        // firing this off in different tasks allows us to fetch both at 
        // the same time instead of waiting for one func completes to move
        // to the next one. (happening concurrently)
        Task { try await fetchUserWalls() }
        Task { try await fetchUserReplies() }

    }
    
    func fetchUserWalls() async throws {
        var walls = try await WallService.fetchUserWalls(uid: user.id)
        
        for i in 0 ..< walls.count {
            walls[i].user = self.user
        }
        
        self.walls = walls
    }
    
    func fetchUserReplies() async throws {
        self.replies = try await WallService.fetchUserReplies(forUser: user)
        try await fetchReplyWallData()
    }
    
    func fetchReplyWallData() async throws {
        
        for i in 0 ..< replies.count {
            let reply = replies[i]
            
            var wall = try await WallService.fetchWall(wallId: reply.wallId)
            wall.user = try await UserService.fetchUser(withUid: wall.ownerUid)
            
            replies[i].wall = wall
            
        }
    }
}
