//
//  PreviewProvider.swift
//  WallApp
//
//  Created by 0xJs on 10/21/23.
//

import SwiftUI
import Firebase

struct PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let user = User(id: NSUUID().uuidString, fullname: "0xJsaad", email: "dev@gmail.com", username: "dev")
    
    lazy var wall = Wall(
        ownerUid: "123",
        caption: "This is a wall post",
        timestamp: Timestamp(),
        likes: 37,
        replyCount: 5,
        user: user
    )
    
    lazy var reply = WallReply(
        wallId: "123",
        replyText: "This is a preview reply",
        wallReplyOwnerUid: "12345",
        wallOwnerUid: "21499194",
        timestamp: Timestamp(),
        wall: wall,
        replyUser: user
    )
}
