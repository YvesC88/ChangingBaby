//
//  FirebaseWrapper.swift
//  ChangingBabyTests
//
//  Created by Yves Charpentier on 08/12/2022.
//

import Firebase

protocol FirebaseProtocol {
    func create(name: String, mail: String, password: String, completion: @escaping (String?, String?) -> ())
    func updateUserProfile(userName: String)
    func signIn(mail: String, password: String, completion: @escaping (String?, String?) -> ())
    func signOut(completion: @escaping (String?, String?) -> ())
    func forgetPwd(mail: String, completion: @escaping (String?) -> ())
}

class FirebaseWrapper: FirebaseProtocol {
    
    func create(name: String, mail: String, password: String, completion: @escaping (String?, String?) -> ()) {
        Auth.auth().createUser(withEmail: mail, password: password) { result, error in
            if let error = error {
                let errorMessage = AuthErrorCode.Code(rawValue: error._code)
                completion(nil, errorMessage?.errorMessage)
            } else {
                completion(result?.user.uid, nil)
            }
        }
    }
    
    func updateUserProfile(userName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges { error in }
    }
    
    func signIn(mail: String, password: String, completion: @escaping (String?, String?) -> ()) {
        Auth.auth().signIn(withEmail: mail, password: password) { result, error in
            if let error = error {
                let errorMessage = AuthErrorCode.Code(rawValue: error._code)
                completion(nil, errorMessage?.errorMessage)
            } else {
                completion(result?.user.uid, nil)
            }
        }
    }
    
    func signOut(completion: @escaping (String?, String?) -> ()) {
        let firebaseAuth = Auth.auth()
        do {
            // success
            try firebaseAuth.signOut()
            completion(nil, nil)
        } catch let signOutError as NSError {
            // fail
            completion(nil, signOutError.localizedDescription)
        }
    }
    
    func forgetPwd(mail: String, completion: @escaping (String?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: mail) { error in
            if let error = error {
                let errorMessage = AuthErrorCode.Code(rawValue: error._code)
                completion(errorMessage?.errorMessage)
            } else {
                completion(nil)
            }
        }
    }
}

