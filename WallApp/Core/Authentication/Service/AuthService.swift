//
//  AuthService.swift
//  WallApp
//
//  Created by 0xJs on 10/17/23.
//
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    
    var isUserAnonymous: Bool {
        return userSession?.isAnonymous ?? false
    }
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        if self.userSession == nil {
            print("DEBUG: No active user session found. Attempting to sign in anonymously.")
            Task {
                do {
                    try await signInAnonymously()
                } catch {
                    print("DEBUG: Failed to automatically sign in anonymously with error: \(error.localizedDescription)")
                }
            }
        } else {
            print("DEBUG: Active user session found with UID \(self.userSession!.uid)")
        }
    }
    
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: User logged in with UID \(result.user.uid) and email \(email).")
            
            try await UserService.shared.fetchCurrentUser()
        } catch {
            print("DEBUG: Failed to signin user with error \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, fullname: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            print("DEBUG: User account created with UID \(result.user.uid), email \(email), and username \(username).")
            
            try await uploadUserData(withEmail: email, fullname: fullname, username: username, id: result.user.uid)
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    /// Sign in anonymously with Firebase
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
        try? Auth.auth().signOut()
        print("DEBUG: User signed out.")
        self.userSession = nil
        UserService.shared.reset()
    }
    
    
    @MainActor
    func uploadUserData(
        withEmail email: String,
        fullname: String,
        username: String,
        id: String
    ) async throws {
        let user = User(id: id, fullname: fullname, email: email, username: username)
        guard let userData = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(userData)
        try await UserService.shared.currentUser = user
    }
    
    /// Link anonymous account to an email
    @MainActor
    func linkAnonymousToEmail(email: String, password: String) async throws {
        guard let currentUser = Auth.auth().currentUser, currentUser.isAnonymous else {
            throw NSError(domain: "WallAppErrorDomain", code: 1001, userInfo: [NSLocalizedDescriptionKey: "No anonymous user is signed in."])
        }
        
        let emailCredential = EmailAuthProvider.credential(withEmail: email, password: password)
        do {
            let authResult = try await currentUser.link(with: emailCredential)
            self.userSession = authResult.user
            print("DEBUG: Anonymous account with UID \(currentUser.uid) linked with email \(email). New UID is \(authResult.user.uid).")
            
        } catch {
            if let error = error as NSError?, error.code == AuthErrorCode.accountExistsWithDifferentCredential.rawValue {
                // Here, we should handle the scenario where the email is already associated with a different Firebase account.
                print("DEBUG: Account already exists with different credentials.")
                // Further code to handle this scenario as per your app's requirements.
            } else {
                print("DEBUG: Failed to link email to anonymous user with error \(error.localizedDescription)")
            }
            throw error
        }
    }
}
