//
//  UserService.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 08/11/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class UserService {
    // MARK: - Properties
    
    var isLogin: Bool {
        return getUser() != nil
    }
    let firebaseWrapper: FirebaseProtocol
    
    init(wrapper: FirebaseProtocol) {
        self.firebaseWrapper = wrapper
    }
    
    // MARK: - Methods
    
    // create an user in FireStore
    func createUser(name: String, mail: String, password: String, completion: @escaping (String?, String?) -> ()) {
        firebaseWrapper.create(name: name, mail: mail, password: password) { userUid, errorMessage in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["name": name, "uid": userUid as Any])
                self.updateUserProfile(userName: name)
                completion(userUid, nil)
            }
        }
    }
    
    // sign in an user
    func signIn(mail: String, password: String, completion: @escaping (String?, String?) ->()) {
        firebaseWrapper.signIn(mail: mail, password: password) { userUid, errorMessage in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
            } else {
                completion(userUid, nil)
            }
        }
    }
    
    // sign out an user
    func signOut(completion: @escaping (String?, String?) ->()) {
        firebaseWrapper.signOut { userUid, errorMessage in
            if let errorMessage = errorMessage {
                completion(userUid, errorMessage)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    // get an user
    func getUser() -> User? { Auth.auth().currentUser }
    
    // add an username for firebase
    func updateUserProfile(userName: String) {
        firebaseWrapper.updateUserProfile(userName: userName)
    }
    
    // send a mail to get a new password
    func forgetPwd(userMail: String, completion: @escaping (String?) -> ()) {
        firebaseWrapper.forgetPwd(mail: userMail) { errorMessage in
            if let errorMessage = errorMessage {
                completion(errorMessage)
            } else {
                completion(nil)
            }
        }
    }
}
