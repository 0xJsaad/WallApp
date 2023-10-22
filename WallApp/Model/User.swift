//
//  User.swift
//  WallApp
//
//  Created by 0xJs on 10/18/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

struct User: Identifiable, Codable, Hashable {
    let id: String  // This serves as the userId
    let fullname: String
    let email: String?
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
