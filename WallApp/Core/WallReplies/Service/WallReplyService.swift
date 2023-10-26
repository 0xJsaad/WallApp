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
    
    static func fetchWallReplies(forWall wall: Wall) async throws -> [WallReply] {
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField("WallId", isEqualTo: wall.id)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: WallReply.self) })
    }
    
    static func fetchWallReplies(forUser user: User) async throws -> [WallReply] {
        .RepliesCollection
        .whereField("wallOwnerUid", isEqualTo: wall.id)
        .getDocuments()

    }
}
