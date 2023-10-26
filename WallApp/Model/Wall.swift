//
//  Wall.swift
//  WallApp
//
//  Created by 0xJs on 10/22/23.
//

import Firebase
import FirebaseFirestoreSwift

struct Wall: Identifiable, Codable {
    @DocumentID var wallId: String?
    let ownerUid: String
    let caption: String
    let timestamp: Timestamp
    var likes: Int
    
    var didLike: Bool? = false
    
    var id: String {
        return wallId ?? NSUUID().uuidString
    }
    
    var user: User?
}
