//
//  SearchUserInteractorTest.swift
//  GitHubAppTests
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

@testable import GitHubApp
import XCTest

class SearchUserInteractorTest: XCTestCase {
    
    var testSubject : SearchUserInteractor!
    
    override func setUp() {
        setupSearchUserInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Mock Classes
    
    class SearchUserPresenterInputSpy : SearchUserPresentationLogic {
        var presentedUserModel : GitHubUserModel?
        var presentedUser = false
        var presentedError = false
        
        func presentUser(response: GitHubUserModel) {
            presentedUser = true
            presentedUserModel = response
        }
        
        func presentError() {
            presentedError = true
        }
    }
    
    class BaseRepositorySpy : IBaseRepository {
        var getGitHubUser : GitHubUserModel?
        var error : NSError?
        func getUserInfo(user: GitHubUser.Request, completionHandler: @escaping (GitHubUserModel?, NSError?) -> Void) {
            completionHandler(getGitHubUser,error)
        }
    }
    
    func setupSearchUserInteractor() {
        testSubject = SearchUserInteractor()
    }
    
    func testSearchUser_ShouldGetGithubUser_WhenUserFound() {
        // Given
        let searchUserPresenterInputSpy = SearchUserPresenterInputSpy()
        testSubject.presenter = searchUserPresenterInputSpy
        let repositorySpy = BaseRepositorySpy()
        testSubject.repositoryLocator = repositorySpy

        // When
        let gitHubUser = GitHubUserModel()
        repositorySpy.getGitHubUser = gitHubUser
        testSubject.searchUser(user: GitHubUser.Request.init(user: "GoogleSamples"))

        // Then
        XCTAssert(searchUserPresenterInputSpy.presentedUser, "Test should get successfull GitHubUserModel response")
        XCTAssert(searchUserPresenterInputSpy.presentedUserModel != nil, "Test should get successfull GitHubUserModel response")
    }
    
    func testSearchUser_ShouldPresentError_WhenNoUserFound() {
        // Given
        let searchUserPresenterInputSpy = SearchUserPresenterInputSpy()
        testSubject.presenter = searchUserPresenterInputSpy
        let repositorySpy = BaseRepositorySpy()
        testSubject.repositoryLocator = repositorySpy
        
        // When
        testSubject.searchUser(user: GitHubUser.Request.init(user: "user test"))
        
        // Then
        XCTAssert(searchUserPresenterInputSpy.presentedError, "Test should present Error")
        XCTAssert(searchUserPresenterInputSpy.presentedUserModel == nil, "Test should get nil GitHubUserModel response")
    }
    
    func testSearchUser_ShouldPresentError_WhenGetError() {
        // Given
        let searchUserPresenterInputSpy = SearchUserPresenterInputSpy()
        testSubject.presenter = searchUserPresenterInputSpy
        let repositorySpy = BaseRepositorySpy()
        testSubject.repositoryLocator = repositorySpy
        
        // When
        let error = NSError.init(domain: "githubapp", code: 404, userInfo: nil)
        
        repositorySpy.error = error
        testSubject.searchUser(user: GitHubUser.Request.init(user: "test user"))
        
        // Then
        XCTAssert(searchUserPresenterInputSpy.presentedError, "Test should present Error")
        XCTAssert(searchUserPresenterInputSpy.presentedUserModel == nil, "Test should get nil GitHubUserModel response")
    }
}
