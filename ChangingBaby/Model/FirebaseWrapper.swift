//
//  FirebaseWrapper.swift
//  ChangingBabyTests
//
//  Created by Yves Charpentier on 08/12/2022.
//

import Firebase

protocol FirebaseProtocol {
    func create(name: String, mail: String, password: String, completion: @escaping (String?, String?) -> ())
    func addDocument(name: String, userId: String, completion: @escaping (String?) -> ())
    func updateUserProfile(userName: String, completion: @escaping (String?) -> ())
    func signIn(mail: String, password: String, completion: @escaping (String?, String?) -> ())
    func signOut(completion: @escaping (String?, String?) -> ())
    func forgetPwd(mail: String, completion: @escaping (String?) -> ())
//    func fetch(collectionID: String, completion: @escaping (QuerySnapshot?, String?) -> ())
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
    
    func addDocument(name: String, userId: String, completion: @escaping (String?) -> ()) {
        let db = Firestore.firestore()
        db.collection("users").addDocument(data: ["name": name, "uid": userId as Any]) { error in
            if let error = error {
                let errorMessage = AuthErrorCode.Code(rawValue: error._code)
                completion(errorMessage?.errorMessage)
            } else {
                completion(nil)
            }
        }
    }
    
    func updateUserProfile(userName: String, completion: @escaping (String?) -> ()) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges { error in
            if let error = error {
                let errorMessage = AuthErrorCode.Code(rawValue: error._code)
                completion(errorMessage?.errorMessage)
            } else {
                completion(nil)
            }
        }
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
    
//    func fetch(collectionID: String, completion: @escaping (QuerySnapshot?, String?) -> ()) {
//        let db = Firestore.firestore()
//        db.collection("places").addSnapshotListener { (querySnapshot, error) in
//            if let querySnapshot = querySnapshot {
//                completion(querySnapshot, nil)
//            } else {
//                completion(nil, error?.localizedDescription)
//            }
//        }
//    }
}
