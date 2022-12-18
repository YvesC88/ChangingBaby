//
//  UserServiceTest.swift
//  ChangingBabyTests
//
//  Created by Yves Charpentier on 14/11/2022.
//

import XCTest
@testable import ChangingBaby

final class UserServiceTest: XCTestCase {
    
    let firebaseMock = FirebaseWrapperMock()
    
    // success to create an user without error message
    func testGivenTryToCreateUserWhenCreateUserThenUserIsCreate() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.createResult = "Test"
        firebaseMock.createError = nil
        // When
        var resultUserId: String?
        var resultError: String?
        userService.createUser(name: "Test", mail: "test@test.fr", password: "Test1234") { userId, errorMessage in
            resultUserId = userId
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertEqual(resultUserId, "Test")
        XCTAssertNil(resultError)
        XCTAssertTrue(firebaseMock.isCreateCalled)
        XCTAssertTrue(firebaseMock.isUpdateProfileCalled)
        XCTAssertTrue(firebaseMock.isAddDocumentCalled)
    }
    
    // failure to create user with error message
        func testGivenTryToCreateUserWhenCreateUserThenUserIsNotCreate() {
            // Given
            let expectation = XCTestExpectation(description: "Wait for queue change.")
            let userService = UserService(wrapper: firebaseMock)
            firebaseMock.createResult = nil
            firebaseMock.createError = "error"
            // When
            var resultUserId: String?
            var resultError: String?
            userService.createUser(name: "Test", mail: "test@test.fr", password: "Test1234") { userId, errorMessage in
                resultUserId = userId
                resultError = errorMessage
                expectation.fulfill()
            }
            // Then
            wait(for: [expectation], timeout: 0.01)
            XCTAssertNil(resultUserId)
            XCTAssertEqual(resultError, "error")
            XCTAssertTrue(firebaseMock.isCreateCalled)
            XCTAssertFalse(firebaseMock.isUpdateProfileCalled)
            XCTAssertFalse(firebaseMock.isAddDocumentCalled)
        }
    
    // failure to add user in document with error message
    func testGivenTryToCreateUserWhenCreateUserThenUserIsNotCreateWithoutErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.createDbError = "error"
        // When
        var resultDbError: String?
        userService.addDocument(name: "Test", userId: "") { errorDb in
            resultDbError = errorDb
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertEqual(resultDbError, "error")
        XCTAssertFalse(firebaseMock.isCreateCalled)
        XCTAssertTrue(firebaseMock.isAddDocumentCalled)
        XCTAssertFalse(firebaseMock.isUpdateProfileCalled)
    }
    
    // failure to update profile with error message
    func testGivenTryToCreateUserWhenCreateUserThenUserNotCreateWithUpdateError() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.createUpdateProfileError = "error"
        // When
        var resultUpdateError: String?
        userService.updateUserProfile(userName: "Test") { errorUpdate in
            resultUpdateError = errorUpdate
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertEqual(resultUpdateError, "error")
        XCTAssertTrue(firebaseMock.isUpdateProfileCalled)
        XCTAssertFalse(firebaseMock.isCreateCalled)
        XCTAssertFalse(firebaseMock.isAddDocumentCalled)
    }
    
    // success to signin an user without error message
    func testGivenUserTryToSignInWhenUserSignInThenHasUserIdAndNoErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.signInResult = "User1"
        firebaseMock.signInError = nil
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.signIn(mail: "test@test.fr", password: "Test1234") { userId, errorMessage in
            resultUserIud = userId
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNotNil(resultUserIud)
        XCTAssertNil(resultError)
        XCTAssertTrue(firebaseMock.isSignInCalled)
    }
    
    // failure to signin an user with error message
    func testGivenUserTryToSignInWhenUserSignInThenHasNoUserIdAndErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.signInResult = nil
        firebaseMock.signInError = "error"
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.signIn(mail: "test@test.fr", password: "Test1234") { userId, errorMessage in
            resultUserIud = userId
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNil(resultUserIud)
        XCTAssertEqual(resultError, "error")
        XCTAssertTrue(firebaseMock.isSignInCalled)
    }
    
    // success to sign out an user without error message
    func testGivenUserTryToSignOutWhenUserSignOutThenHasNoUserIdAndNoErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.signOutResult = nil
        firebaseMock.signOutError = nil
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.signOut { userId, errorMessage in
            resultUserIud = userId
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNil(resultUserIud)
        XCTAssertNil(resultError)
        XCTAssertTrue(firebaseMock.isSignOutCalled)
    }
    
    // failure to sign out an user with error message
    func testGivenUserTryToSignOutWhenUserSignOutThenHasUserIdAndErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.signOutResult = "Test"
        firebaseMock.signOutError = "error"
        // When
        var resultUserId: String?
        var resultError: String?
        userService.signOut { userId, errorMessage in
            resultUserId = userId
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertEqual(resultUserId, "Test")
        XCTAssertEqual(resultError, "error")
        XCTAssertTrue(firebaseMock.isSignOutCalled)
    }
    
    // success to send a mail to the user without error message
    func testGivenUserWantANewPwdWhenGetNewPwdThenHasNoErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.forgetPwdError = nil
        // When
        var resultError: String?
        userService.forgetPwd(userMail: "test@test.fr") { errorMessage in
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNil(resultError)
        XCTAssertTrue(firebaseMock.isForgetPwdCalled)
    }
    
    // failure to send a mail to the user with error message
    func testGivenUserWantANewPwdWhenGetNewPwdThenHasErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.forgetPwdError = "error"
        // When
        var resultError: String?
        userService.forgetPwd(userMail: "test@test.fr") { errorMessage in
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertEqual(resultError, "error")
        XCTAssertTrue(firebaseMock.isForgetPwdCalled)
    }
}
