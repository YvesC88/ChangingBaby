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
        var resultUserIud: String?
        var resultError: String?
        userService.createUser(name: "Test", mail: "test@test.fr", password: "Test1234") { userIud, errorMessage in
            resultUserIud = userIud
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertEqual(resultUserIud, "Test")
        XCTAssertNil(resultError)
        XCTAssertTrue(firebaseMock.isCreateCalled)
    }
    
    // failure to create user with error message
    func testGivenTryToCreateUserWhenCreateUserThenUserIsNotCreate() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.createResult = nil
        firebaseMock.createError = "error"
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.createUser(name: "Test", mail: "test@test.fr", password: "Test1234") { userIud, errorMessage in
            resultUserIud = userIud
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNil(resultUserIud)
        XCTAssertEqual(resultError, "error")
        XCTAssertTrue(firebaseMock.isCreateCalled)
        XCTAssertFalse(firebaseMock.isUpdateProfileCalled)
    }
    
    // success to signin an user without error message
    func testGivenUserTryToSignInWhenUserSignInThenHasUserIdAndNoErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.createResult = "User1"
        firebaseMock.createError = nil
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.signIn(mail: "test@test.fr", password: "Test1234") { userUid, errorMessage in
            resultUserIud = userUid
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
        firebaseMock.createResult = nil
        firebaseMock.createError = "error"
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.signIn(mail: "test@test.fr", password: "Test1234") { userUid, errorMessage in
            resultUserIud = userUid
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
        firebaseMock.createResult = "Test"
        firebaseMock.createError = "error"
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.signOut { userUid, errorMessage in
            resultUserIud = userUid
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertEqual(resultUserIud, "Test")
        XCTAssertEqual(resultError, "error")
        XCTAssertTrue(firebaseMock.isSignOutCalled)
    }
    
    // failure to sign out an user with error message
    func testGivenUserTryToSignOutWhenUserSignOutThenHasUserIdAndErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.createResult = nil
        firebaseMock.createError = nil
        // When
        var resultUserIud: String?
        var resultError: String?
        userService.signOut { userUid, errorMessage in
            resultUserIud = userUid
            resultError = errorMessage
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 0.01)
        XCTAssertNil(resultUserIud)
        XCTAssertNil(resultError)
        XCTAssertTrue(firebaseMock.isSignOutCalled)
    }
    
    // success to send a mail to the user without error message
    func testGivenUserWantANewPwdWhenGetNewPwdThenHasNoErrorMessage() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let userService = UserService(wrapper: firebaseMock)
        firebaseMock.createError = nil
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
        firebaseMock.createError = "error"
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
