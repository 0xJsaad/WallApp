//
//  User.swift
//  WallApp
//
//  Created by 0xJs on 10/18/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
}
