//
//  UserServiceTest.swift
//  ChangingBabyTests
//
//  Created by Yves Charpentier on 14/11/2022.
//

import XCTest
@testable import ChangingBaby

final class UserServiceTest: XCTestCase {
    
    func testGivenTryToCreateUserWhenCreateUserThenUserIsCreate() {
        // Given
        let userService = UserService()
        // When
        userService.createUser(userName: "Test", mail: "test@test.com", password: "Test05") { error in }
        // Then
    }
    
    func testGivenUserWantToSignInWhenSignInThenUserIsSignIn() {
        // Given
        
        // When
        
        // Then
    }
    
    func testGivenUserWantToSignOutWhenSignOutThenUserIsSignOut() {
        // Given
        
        // When
        
        // Then
    }
    
    func testGivenIsUserSignInWhenGetUserThenUserIsSignIn() {
        // Given
        
        // When
        
        // Then
    }
}
