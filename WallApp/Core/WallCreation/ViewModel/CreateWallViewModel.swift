//
//  CreateWallViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/22/23.
//
import Firebase
import Foundation

class CreateWallViewModel: ObservableObject {
    func uploadWall(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let wall = Wall(ownerUid: uid, caption: caption, timestamp: Timestamp(), likes: 0, replyCount: 0)
        try await WallService.uploadWall(wall)
    }
    
}

