//
//  WallService.swift
//  WallApp
//
//  Created by 0xJs on 10/22/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct WallService {
    
    static func uploadWall(_ wall: Wall) async throws {
        guard let wallData = try? Firestore.Encoder().encode(wall) else { return }
        try await Firestore.firestore().collection("wall posts").addDocument(data: wallData)
    }
    
    static func fetchWalls() async throws -> [Wall] {
        let snapshot = try await Firestore
            .firestore()
            .collection("wall posts")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Wall.self) })
    }
    
    static func fetchUserWalls(uid: String) async throws -> [Wall] {
        let snapshot = try await Firestore
            .firestore()
            .collection("wall posts")
            .whereField("ownerUid",isEqualTo: uid)
            .getDocuments()
        
        
        let walls = snapshot.documents.compactMap({ try? $0.data(as: Wall.self) })
        return walls.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
    }
    
    static func fetchUserReplies(forUser user: User) async throws  -> [WallReply] {
        let snapshot = try await FirestoreConstants
            .RepliesCollection
            .whereField("wallReplyOwnerUid", isEqualTo: user.id)
            .getDocuments()
        
        var replies = snapshot.documents.compactMap({ try? $0.data(as: WallReply.self) })
        
        for i in 0 ..< replies.count {
            replies[i].replyUser = user
        }
        
        return replies
    }
    
    static func fetchWall(wallId: String) async throws -> Wall {
        let snapshot = try await FirestoreConstants
            .WallsCollection
            .document(wallId)
            .getDocument()
        
        return try snapshot.data(as: Wall.self)
    }
}
    
// MARK: - Likes

extension WallService {
    static func likeWall(_ wall: Wall) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let wallRef = FirestoreConstants.WallsCollection.document(wall.id)
        
        async let _ = try await wallRef.collection("wall-likes").document(uid).setData([:])
        async let _ = try await wallRef.updateData(["likes": wall.likes + 1])
        async let _ = try await FirestoreConstants.UserCollection.document(uid).collection("user-likes").document(wall.id).setData([:])
    }
    
    static  func unlikeWall(_ wall: Wall) async throws {
        guard wall.likes > 0 else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let wallRef = FirestoreConstants.WallsCollection.document(wall.id)
        
        async let _ = wallRef.collection("wall-likes").document(uid).delete()
        async let _ = try await FirestoreConstants.UserCollection.document(uid).collection("user-likes").document(wall.id).delete()
        async let _ = try await wallRef.updateData(["likes": wall.likes - 1])
    }
    
    static func checkIfUserLikedWall(_ wall: Wall) async throws -> (Bool) {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        
        
        let snapshot = try await FirestoreConstants
            .UserCollection
            .document(uid)
            .collection("user-likes")
            .document(wall.id)
            .getDocument()
        
        return snapshot.exists
    }
}

