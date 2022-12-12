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
    var isCreateCalled: Bool = false
    var isUpdateProfileCalled: Bool = false
    var isSignInCalled: Bool = false
    var isSignOutCalled: Bool = false
    var isForgetPwdCalled: Bool = false
    
    func create(name: String, mail: String, password: String, completion: @escaping (String?, String?) -> ()) {
        isCreateCalled = true
        completion(createResult, createError)
    }
    
    func updateUserProfile(userName: String) {
        isUpdateProfileCalled = true
    }
    
    func signIn(mail: String, password: String, completion: @escaping (String?, String?) -> ()) {
        isSignInCalled = true
        completion(createResult, createError)
    }
    
    func signOut(completion: @escaping (String?, String?) -> ()) {
        isSignOutCalled = true
        completion(createResult, createError)
    }
    
    func forgetPwd(mail: String, completion: @escaping (String?) -> ()) {
        isForgetPwdCalled = true
        completion(createError)
    }
}
