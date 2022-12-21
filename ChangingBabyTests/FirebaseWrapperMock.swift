//
//  FirebaseWrapperMock.swift
//  ChangingBabyTests
//
//  Created by Yves Charpentier on 08/12/2022.
//

@testable import ChangingBaby

final class FirebaseWrapperMock: FirebaseProtocol {
    var createResult: String?
    var createError: String?
    var createDbError: String?
    var createUpdateProfileError: String?
    var signInResult: String?
    var signInError: String?
    var signOutResult: String?
    var signOutError: String?
    var forgetPwdError: String?
    var placeResult: [Place]?
    var placeError: String?
    var isCreateCalled: Bool = false
    var isAddDocumentCalled: Bool = false
    var isUpdateProfileCalled: Bool = false
    var isSignInCalled: Bool = false
    var isSignOutCalled: Bool = false
    var isForgetPwdCalled: Bool = false
    var isFetchPlaceCalled: Bool = false
    
    func create(name: String, mail: String, password: String, completion: @escaping (String?, String?) -> ()) {
        isCreateCalled = true
        completion(createResult, createError)
    }
    
    func addDocument(name: String, userId: String, completion: @escaping (String?) -> ()) {
        isAddDocumentCalled = true
        completion(createDbError)
    }
    
    func updateUserProfile(userName: String, completion: @escaping (String?) -> ()) {
        isUpdateProfileCalled = true
        completion(createUpdateProfileError)
    }
    
    func signIn(mail: String, password: String, completion: @escaping (String?, String?) -> ()) {
        isSignInCalled = true
        completion(signInResult, signInError)
    }
    
    func signOut(completion: @escaping (String?, String?) -> ()) {
        isSignOutCalled = true
        completion(signOutResult, signOutError)
    }
    
    func forgetPwd(mail: String, completion: @escaping (String?) -> ()) {
        isForgetPwdCalled = true
        completion(forgetPwdError)
    }
    
    func fetch(collectionID: String, completion: @escaping ([Place]?, String?) -> ()) {
        isFetchPlaceCalled = true
        completion(placeResult, placeError)
    }
}
