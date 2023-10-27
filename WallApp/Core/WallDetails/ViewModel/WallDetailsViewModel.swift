//
//  WallDetailsViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/26/23.
//

import Foundation

@MainActor
class WallDetailsViewModel: ObservableObject {
    @Published var replies = [WallReply]()

    private let wall: Wall
    
    init(wall: Wall) {
        self.wall = wall
        Task { try await fetchWallReplies() }
    }
    
    private func fetchWallReplies() async throws {
        self.replies = try await WallReplyService.fetchWallReplies(forWall: wall)
        try await fetchUserDataForReplies()
    }
    
    private func fetchUserDataForReplies() async throws {
        for i in 0 ..< replies.count {
            let reply = replies[i]
            
            async let user = try await UserService.fetchUser(withUid: reply.wallReplyOwnerUid)
            self.replies[i].replyUser = try await user
        }
    }
}
