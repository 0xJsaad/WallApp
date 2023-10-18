//
//  AuthService.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to signin user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await uploadUserData(withEmail: email, fullname: fullname, username: username, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    /// anoymous implementatiion with firebase
    @MainActor
    func signInAnonymously() async throws {
        do {
            let result = try await Auth.auth().signInAnonymously()
            self.userSession = result.user
            print("DEBUG: Signed in anonymously with UID \(result.user.uid)")
        } catch {
            print("DEBUG: Failed to sign in anonymously with error \(error.localizedDescription)")
            throw error
        }
    }
    func signOut() {
        try? Auth.auth().signOut() // signs out on backend firebase
        self.userSession = nil // this removes session locally and updates routing
    }
    
    @MainActor
    private func uploadUserData(
        withEmail email: String,
        fullname: String,
        username: String,
        id: String
    ) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
    }
}


