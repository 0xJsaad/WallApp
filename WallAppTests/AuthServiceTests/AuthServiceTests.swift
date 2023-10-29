//
//  AuthServiceTests.swift
//  WallAppTests
//
//  Created by 0xJs on 10/28/23.
//

import XCTest
@testable import WallApp
// Import other necessary modules such as FirebaseAuth

final class AuthServiceTests: XCTestCase {
    
    var authService: AuthService!
    
    override func setUp() {
        super.setUp()
        authService = AuthService.shared // Initializing the AuthService instance before each test
    }
    
    override func tearDown() {
        authService = nil // Cleaning up the AuthService instance after each test
        super.tearDown()
    }
    
    func testLoginSuccess() async throws {
        // Mock: Setup a successful login response from Firebase.
        
        do {
            try await authService.login(withEmail: "test@example.com", password: "password123")
            // Verify: Ensure that the login executes without errors and other expected outcomes.
        } catch {
            XCTFail("Unexpected error during login: \(error)")
        }
    }
    
    func testCreateUserSuccess() async throws {
        // Mock: Setup a successful user creation response from Firebase and Firestore.
        
        do {
            try await authService.createUser(withEmail: "test@example.com", password: "password123", fullname: "Test User", username: "testuser")
            // Verify: Ensure that the user creation executes without errors and other expected outcomes.
        } catch {
            XCTFail("Unexpected error during user creation: \(error)")
        }
    }
}


