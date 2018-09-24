//
//  UserDetailPresenterTest.swift
//  GitHubAppTests
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

@testable import GitHubApp
import XCTest

class UserDetailPresenterTest: XCTestCase {
    
    var testSubject: UserDetailPresenter!

    override func setUp() {
        setupUserDetailPresenterTest()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    class UserDetailDisplayLogicSpy: UserDetailDisplayLogic {
        var displayedUserViewModel: UserDetail.ViewModel?
        var displayedUser = false
        
        func displayUserDetail(viewModel: UserDetail.ViewModel) {
            displayedUser = true
            displayedUserViewModel = viewModel
        }
    }
    
    private func setupUserDetailPresenterTest(){
        testSubject = UserDetailPresenter()
    }
    
    func testPresentUserDetail_ShoulDisplayUserDetail() {
        // Given
        let userDetailDisplayLogicSpy = UserDetailDisplayLogicSpy()
        testSubject.viewController = userDetailDisplayLogicSpy
        
        // When
        let userDetail = UserDetail.ViewModel(request: UserDetail.Request())
        testSubject.presentUserDetail(userDetail: userDetail)
        
        // Then
        XCTAssert(userDetailDisplayLogicSpy.displayedUser, "presentUserDetail should DisplayUserDetail")
    }
    
    
    func testPresentUserDetail_ShoulDisplayUserDetail_WithNewFormat() {
        // Given
        let expectedUserCreated = "Created: "
        let expectedEmail = "Email: test.com"
        let expectedFollowers = "Followers: 3"
        
        let userDetailDisplayLogicSpy = UserDetailDisplayLogicSpy()
        testSubject.viewController = userDetailDisplayLogicSpy
        
        // When
        let userDetail = UserDetail.ViewModel(userIcon: "icon", userName: "test", userCreatedDate: "", userUpdatedDate: "", userEmail: "test.com", userBio: "My Bio test", userRepos: "1", userGists: "2", userFollowers: "3", userFollowing: "4")
        testSubject.presentUserDetail(userDetail: userDetail)
        
        // Then
        XCTAssert(userDetailDisplayLogicSpy.displayedUser, "presentUserDetail should DisplayUserDetail")
        XCTAssertEqual(expectedUserCreated, userDetailDisplayLogicSpy.displayedUserViewModel?.userCreatedDate, "Should display the createdDate with the custom format")
        XCTAssertEqual(expectedEmail, userDetailDisplayLogicSpy.displayedUserViewModel?.userEmail, "Should display the email with the custom format")
        XCTAssertEqual(expectedFollowers, userDetailDisplayLogicSpy.displayedUserViewModel?.userFollowers, "Should display the followers with the custom format")
    }

}
