//
//  ContentActionsButtonsViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/25/23.
//

import Foundation

@MainActor
class ContentActionsButtonsViewModel: ObservableObject {
    @Published var wall: Wall
    
    init(wall: Wall) {
        self.wall = wall
        Task { try await checkIfUserLikedWall() }
    }
    
    func likeWall() async throws {
        try await WallService.likeWall(wall)
        self.wall.didLike = true
        self.wall.likes += 1
    }
    
    func unlikeWall() async throws {
        try await WallService.unlikeWall(wall)
        self.wall.didLike = false
        self.wall.likes -= 1
    }
    
    func checkIfUserLikedWall() async throws {
        let didLike = try await WallService.checkIfUserLikedWall(wall)
        
        // only executing update if wall post has been liked
        if didLike {
            self.wall.didLike = true
        }
    }
    
}
