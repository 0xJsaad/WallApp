//
//  WallReplyViewModel.swift
//  WallApp
//
//  Created by 0xJs on 10/25/23.
//

import Foundation
import Firebase
class WallReplyViewModel: ObservableObject {
    
    func uploadWallReply(replyText: String, wall: Wall) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let reply = WallReply(
            wallId: wall.id,
            replyText: replyText,
            wallReplyOwnerUid: uid,
            wallOwnerUid: wall.ownerUid,
            timestamp: Timestamp()
        )
        
        try await WallReplyService.uploadWallReply(reply, toWall: wall)
    }
}
