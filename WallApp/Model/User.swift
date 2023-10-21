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
    
    
    final class UserManager {
        static let shared = UserManager()
        private init() { }
        
        private let userCollection: CollectionReference = Firestore.firestore().collection("users")
        
        private func userDocument(userId: String) -> DocumentReference {
            userCollection.document(userId)
        }
        
        private let encoder: Firestore.Encoder = {
            let encoder = Firestore.Encoder()
            return encoder
        }()
        
        private let decoder: Firestore.Decoder = {
            let decoder = Firestore.Decoder()
            return decoder
        }()
        
        func createNewUser(user: User) async throws {
            try userDocument(userId: user.id).setData(from: user, merge: false)
        }
        
        func getUser(userId: String) async throws -> User {
            try await userDocument(userId: userId).getDocument(as: User.self)
        }
        
        func updateUserProfileImageUrl(userId: String, url: String?) async throws {
            let data: [String:Any] = [
                "profileImageUrl": url ?? NSNull()
            ]
            try await userDocument(userId: userId).updateData(data)
        }
        
        func updateBio(userId: String, bio: String?) async throws {
            let data: [String:Any] = [
                "bio": bio ?? NSNull()
            ]
            try await userDocument(userId: userId).updateData(data)
        }
        
        func switchAnonymousStatus(userId: String, isAnonymous: Bool) async throws {
            let data: [String:Any] = [
                "isAnonymous": isAnonymous
            ]
            try await userDocument(userId: userId).updateData(data)
        }
    }
}
