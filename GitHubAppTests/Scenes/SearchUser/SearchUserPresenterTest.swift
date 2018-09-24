//
//  SearchUserPresenterTest.swift
//  GitHubAppTests
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

@testable import GitHubApp
import XCTest

class SearchUserPresenterTest: XCTestCase {
    
    var testSubject: SearchUserPresenter!

    override func setUp() {
        setupSearchUserPresenterTest()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func setupSearchUserPresenterTest(){
        testSubject = SearchUserPresenter()
    }
    
    class SearchUserDisplayLogicSpy: SearchUserDisplayLogic {
        var displayedUserModel: GitHubUserModel?
        var displayedUser = false
        var displayedError = false
        
        func displayUser(user: GitHubUserModel) {
            displayedUser = true
            displayedUserModel = user
        }
        
        func displayError() {
            displayedError = true
        }
    }
    
    func testPresenUser_ShouldDisplayUser_WhitUserModel() {
        // Given
        let searchUserDisplayLogicSpy = SearchUserDisplayLogicSpy()
        testSubject.viewController = searchUserDisplayLogicSpy
        
        // When
        let gitHubUser = GitHubUserModel()
        gitHubUser.name = "Test"
        
        testSubject.presentUser(response: gitHubUser)

        // Then
        XCTAssert(searchUserDisplayLogicSpy.displayedUser,"presentUser should Call DisplayUser")
    }
    
    func testPresenUser_ShouldDisplayUser_WhitNicknameInsteadOfName() {
        // Given
        let expectedName = "@Test"
        let searchUserDisplayLogicSpy = SearchUserDisplayLogicSpy()
        testSubject.viewController = searchUserDisplayLogicSpy
        
        // When
        let gitHubUser = GitHubUserModel()
        gitHubUser.login = "Test"
        
        testSubject.presentUser(response: gitHubUser)
        
        // Then
        XCTAssert(searchUserDisplayLogicSpy.displayedUser,"presentUser should Call DisplayUser")
        XCTAssertEqual(searchUserDisplayLogicSpy.displayedUserModel!.name, expectedName, "presentUser with given user should have the same name than the mock")
    }
    
    func testPresenUser_ShouldDisplayUser_WhitNameModified() {
        // Given
        let expectedName = "@Test"
        let searchUserDisplayLogicSpy = SearchUserDisplayLogicSpy()
        testSubject.viewController = searchUserDisplayLogicSpy
        
        // When
        let gitHubUser = GitHubUserModel()
        gitHubUser.name = "Test"
        
        testSubject.presentUser(response: gitHubUser)
        
        // Then
        XCTAssert(searchUserDisplayLogicSpy.displayedUser,"presentUser should Call DisplayUser")
        XCTAssertEqual(searchUserDisplayLogicSpy.displayedUserModel!.name, expectedName, "presentUser with given user should have the same name than the mock")
    }
    
    func testPresentError_ShouldDisplayError(){
        // Given
        let searchUserDisplayLogicSpy = SearchUserDisplayLogicSpy()
        testSubject.viewController = searchUserDisplayLogicSpy
        
        // When
        testSubject.presentError()
        
        // Then
        XCTAssert(searchUserDisplayLogicSpy.displayedError,"presentError should Call DisplayError")
    }
    

}
