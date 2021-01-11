//
//  GithubCommitFetcherUITests.swift
//  GithubCommitFetcherUITests
//
//  Created by chrchg on 1/10/21.
//  Copyright © 2021 chrchg. All rights reserved.
//

import XCTest
@testable import GithubCommitFetcher

class GithubCommitFetcherUITests: XCTestCase {
    
    let app = XCUIApplication()
    let repoOwnerString = "Repository owner"
    let repoNameString = "Repository name"
    let viewCommitsString = "View Commits"
    let errorString = "Error"
    let okayString = "Okay"
    let commitsString = "Commits"
    let backString = "Back"
    
    // Make sure Connect Hardware Keyboard in the simulator is disabled
    override func setUpWithError() throws {
        self.app.launch()
    }
    
    func testViewsAppear() throws {
        let ownerTextField = self.app.textFields[self.repoOwnerString]
        let repoTextField = self.app.textFields[self.repoNameString]
        let submitButton = self.app.staticTexts[self.viewCommitsString]
        XCTAssertTrue(ownerTextField.exists)
        XCTAssertTrue(repoTextField.exists)
        XCTAssertTrue(submitButton.exists)
    }
    
    func testEmptyInputTriggersErrorMessage() throws {
        let emptyOwner = ""
        let emptyRepo = ""
        let ownerTextField = self.app.textFields[self.repoOwnerString]
        let repoTextField = self.app.textFields[self.repoNameString]
        ownerTextField.tap()
        ownerTextField.typeText(emptyOwner)
        repoTextField.tap()
        repoTextField.typeText(emptyRepo)
        self.app.staticTexts[self.viewCommitsString].tap()
        let alertView = self.app.alerts[self.errorString]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: alertView, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        alertView.scrollViews.otherElements.buttons[self.okayString].tap()
    }

    func testInvalidInputTriggersErrorMessage() throws {
        let invalidOwner = "s%df"
        let invalidRepo = "s%df"
        let ownerTextField = self.app.textFields[self.repoOwnerString]
        let repoTextField = self.app.textFields[self.repoNameString]
        ownerTextField.tap()
        ownerTextField.typeText(invalidOwner)
        repoTextField.tap()
        repoTextField.typeText(invalidRepo)
        self.app.staticTexts[self.viewCommitsString].tap()
        let alertView = self.app.alerts[self.errorString]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: alertView, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        alertView.scrollViews.otherElements.buttons[self.okayString].tap()
    }
    
    func testValidInputShowsTableView() throws {
        let validOwner = "xtnchang"
        let validRepo = "GithubCommitFetcher"
        let ownerTextField = app.textFields[self.repoOwnerString]
        let repoTextField = app.textFields[self.repoNameString]
        ownerTextField.tap()
        ownerTextField.typeText(validOwner)
        repoTextField.tap()
        repoTextField.typeText(validRepo)
        self.app.staticTexts[self.viewCommitsString].tap()
        let commits = self.app.navigationBars[self.commitsString]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: commits, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        self.app.navigationBars[self.commitsString].buttons[self.backString].tap()
    }
}
