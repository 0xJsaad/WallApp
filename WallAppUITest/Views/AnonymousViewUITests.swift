//
//  AnonymousViewUITests.swift
//  WallAppUITests
//
//  Created by 0xJs on 10/28/23.
//

import XCTest

class RegistrationNavigationUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testNavigateToCreateAccount() {
        // Navigate to AnonymousView by tapping the 'Stay Anonymously' button in LoginView
        app.buttons["Stay Anonymously"].tap()
        
        // Navigate to ExploreView by tapping the corresponding tab in the tab bar
        app.tabBars.buttons.element(boundBy: 1).tap() // Assumes ExploreView is the second tab
        
        // Tap the 'Create Account' button in ExploreView and verify its existence
        let createAccountButton = app.buttons["Create Account"]
        XCTAssertTrue(createAccountButton.waitForExistence(timeout: 5), "Create Account button should exist.")
        createAccountButton.tap()
        
    }
}
