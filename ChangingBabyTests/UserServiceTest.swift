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
    
//    func testGivenTryToCreateUserWhenCreateUserThenUserIsCreate() {
//        // Given
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        let userService = UserService(wrapper: firebaseMock)
//        firebaseMock.createResult = "User"
//        firebaseMock.createError = nil
//        // When
//        var resultUserIud: String?
//        var resultError: String?
//        userService.createUser(name: "Yves", mail: "test@test.fr", password: "Yves1234") { userIud, errorMessage in
//            resultUserIud = userIud
//            resultError = errorMessage
//            expectation.fulfill()
//        }
//        // Then
//        wait(for: [expectation], timeout: 0.01)
//        XCTAssertEqual(resultUserIud, "User")
//        XCTAssertNil(resultError)
//        XCTAssertTrue(firebaseMock.isCreateCalled)
//    }
    
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
}
