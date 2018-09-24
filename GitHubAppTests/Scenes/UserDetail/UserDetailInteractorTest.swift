//
//  UserDetailInteractorTest.swift
//  GitHubAppTests
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

@testable import GitHubApp
import XCTest

class UserDetailInteractorTest: XCTestCase {
    
    var testSubject: UserDetailInteractor!

    override func setUp() {
        setupUserDetailInteractorTest()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func setupUserDetailInteractorTest(){
        testSubject = UserDetailInteractor()
    }
    
    class UserDetailPresentationLogicSpy: UserDetailPresentationLogic {
        var presentedUserDetail = false
        
        func presentUserDetail(userDetail: UserDetail.ViewModel) {
            presentedUserDetail = true
        }
    }
    
    
    func testGetUserDetail_ShouldPresentUserDetail() {
        // Given
        let userDetailPresentationLogicSpy = UserDetailPresentationLogicSpy()
        testSubject.presenter = userDetailPresentationLogicSpy
        
        // When
        let detail = UserDetail.Request()
        testSubject.getUserDetail(userDetail: detail)
        
        // Then
        XCTAssert(userDetailPresentationLogicSpy.presentedUserDetail, "getUserDetail should present user detail.")
    }
    

}
