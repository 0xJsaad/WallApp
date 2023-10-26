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
    
    let user = User(id: UUID().uuidString, fullname: "0xJsaad", email: "dev@gmail.com", username: "dev")
    
    let wall = Wall(ownerUid: "123", caption: "This is a wall post", timestamp: Timestamp(), likes: 0, replyCount: 0)
}
