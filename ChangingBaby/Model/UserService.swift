//
//  UserService.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 08/11/2022.
//

import UIKit
import Firebase
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
        firebaseWrapper.create(name: name, mail: mail, password: password) { userId, errorMessage in
            guard let userId = userId else {
                completion(nil, errorMessage)
                return
            }
            self.addDocument(name: name, userId: userId) { error in
                guard error != nil else {
                    self.updateUserProfile(userName: name) { error in
                        guard error != nil else {
                            completion(userId, nil)
                            return
                        }
                        completion(nil, error)
                    }
                    return
                }
                completion(nil, error)
            }
        }
    }
    // add name and userId in document in firebase
    func addDocument(name: String, userId: String, completion: @escaping (String?) -> ()) {
        firebaseWrapper.addDocument(name: name, userId: userId) { error in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    // add an username for firebase
    func updateUserProfile(userName: String, completion: @escaping (String?) ->()) {
        firebaseWrapper.updateUserProfile(userName: userName) { error in
            if let errorMessage = error {
                completion(errorMessage)
            } else {
                completion(nil)
            }
        }
    }
    
    // sign in an user
    func signIn(mail: String, password: String, completion: @escaping (String?, String?) ->()) {
        firebaseWrapper.signIn(mail: mail, password: password) { userId, errorMessage in
            if let errorMessage = errorMessage {
                completion(nil, errorMessage)
            } else {
                completion(userId, nil)
            }
        }
    }
    
    // sign out an user
    func signOut(completion: @escaping (String?, String?) ->()) {
        firebaseWrapper.signOut { userId, errorMessage in
            if let errorMessage = errorMessage {
                completion(userId, errorMessage)
            } else {
                completion(nil, nil)
            }
        }
    }
    
    // get an user
    func getUser() -> User? { Auth.auth().currentUser }
    
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
    
    func deleteUser() {
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
        currentUser?.delete()
        db.collection("users").document(currentUser?.uid ?? "").delete()
    }
}
