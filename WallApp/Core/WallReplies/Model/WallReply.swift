//
//  WallReply.swift
//  WallApp
//
//  Created by 0xJs on 10/25/23.
//
import FirebaseFirestoreSwift
import Firebase


struct WallReply: Identifiable, Codable {
    @DocumentID var replyId: String?
    let wallId: String
    let replyText: String
    let wallReplyOwnerUid: String
    let wallOwnerUid: String
    let timestamp: Timestamp
    
    var wall: Wall?
    var replyUser: User?
    
    var id: String {
        return replyId ?? NSUUID().uuidString
    }
}
