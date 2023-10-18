//
//  AuthService.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//
import FirebaseAuth
import Firebase

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("DEBUG: Created user \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    /// anoymous implementatiion with firebase
    @MainActor
    func signInAnonymously() async throws {
        do {
            let result = try await Auth.auth().signInAnonymously()
            print("DEBUG: Signed in anonymously with UID \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to sign in anonymously with error \(error.localizedDescription)")
            throw error
        }
    }
}

