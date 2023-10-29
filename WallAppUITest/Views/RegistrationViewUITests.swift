//
//  RegistrationViewUITests.swift
//  WallAppUITests
//
//  Created by 0xJs on 10/28/23.
//

import XCTest

class RegistrationViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        
        // Navigate to RegistrationView from LoginView
        let signUpButton = app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", "Sign Up")).element
        XCTAssertTrue(signUpButton.waitForExistence(timeout: 5), "Sign Up button should exist.")
        signUpButton.tap()
    }
    
    func testTextFieldExistence() {
        // Verify that all text fields exist in the RegistrationView
        XCTAssertTrue(app.textFields["Enter your email"].waitForExistence(timeout: 5), "Email text field should exist.")
        XCTAssertTrue(app.secureTextFields["Enter your password"].waitForExistence(timeout: 5), "Password text field should exist.")
        XCTAssertTrue(app.textFields["Enter your full name"].waitForExistence(timeout: 5), "Full name text field should exist.")
        XCTAssertTrue(app.textFields["Enter your username"].waitForExistence(timeout: 5), "Username text field should exist.")
    }
    
    func testSignUpButton() {
        // Access the Sign Up button by its visible text
        let signUpButton = app.buttons["Sign Up"]
        XCTAssertTrue(signUpButton.waitForExistence(timeout: 5), "Sign Up button should exist.")
        signUpButton.tap()
    }
    
    func testSignInNavigation() {
        // Access the "Sign in" button by its visible text and tap it to dismiss the RegistrationView
        let signInButton = app.buttons.matching(NSPredicate(format: "label CONTAINS %@", "Sign in")).firstMatch
        XCTAssertTrue(signInButton.waitForExistence(timeout: 5), "Sign In button should exist.")
        signInButton.tap()
    }
}
