//
//  LoginViewUITests.swift
//  WallAppUITests
//
//  Created by 0xJs on 10/28/23.
//

import XCTest

class LoginViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testLoginButton() {
        // Ensure the Login button exists and perform a tap action to test its functionality.
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.exists, "Login button should exist.")
        loginButton.tap()
    }
    
    func testAnonymousLoginButton() {
        // Ensure the Anonymous Login button exists and perform a tap action to test its functionality.
        let anonymousLoginButton = app.buttons["Stay Anonymously"]
        XCTAssertTrue(anonymousLoginButton.exists, "Anonymous Login button should exist.")
        anonymousLoginButton.tap()
    }
    
    func testSignUpNavigation() {
        // Navigate or ensure you are at the LoginView
        let signUpLink = app.staticTexts["Sign Up"] // Using staticTexts instead of links
        XCTAssertTrue(signUpLink.waitForExistence(timeout: 5), "Sign Up link should exist.")
        signUpLink.tap()
    }
}
