//
//  WallReplyService.swift
//  WallApp
//
//  Created by 0xJs on 10/25/23.
//
import Foundation
import Firebase
import FirebaseFirestoreSwift

struct WallReplyService {
    
    static func uploadWallReply(_ reply: WallReply, toWall wall: Wall) async throws {
        guard let replyData = try? Firestore.Encoder().encode(reply) else { return }
        try await FirestoreConstants.RepliesCollection.document().setData(replyData)
        try await FirestoreConstants.WallsCollection.document(wall.id).updateData([
            "replyCount": wall.replyCount + 1
        ])
    }
}
