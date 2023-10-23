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
        let ref = try await Firestore.firestore().collection("wall posts").addDocument(data: wallData)
    }
}
