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
    
    var errorLogin: String?
    var userName: String?
    var isLogin: Bool {
        return getUser() != nil
    }
    
    // MARK: - Methods
    
    // create an user in FireStore
    
    func createUser(name: String, mail: String, password: String, completion: @escaping (String?) -> ()) {
        Auth.auth().createUser(withEmail: mail, password: password) { result, error in
            guard error != nil else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["name": name, "uid": result!.user.uid]) { (error) in
                    guard error != nil else {
                        self.updateUserProfile(userName: name)
                        completion(nil)
                        return
                    }
                    guard let errorCode = AuthErrorCode.Code(rawValue: 0) else { return }
                    completion(errorCode.errorMessage)
                }
                return }
            guard let errorCode = AuthErrorCode.Code(rawValue: error?._code ?? 0) else { return }
            completion(errorCode.errorMessage)
        }
    }
    
    // sign in an user
    func signIn(mail: String, password: String, completion: @escaping (String?) ->()) {
        Auth.auth().signIn(withEmail: mail, password: password) { user, error in
            guard error != nil else {
                completion(nil)
                return
            }
            guard let errorCode = AuthErrorCode.Code(rawValue: error?._code ?? 0) else { return }
            completion(errorCode.errorMessage)
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signin out: %@", signOutError)
        }
    }
    
    func getUser() -> User? { Auth.auth().currentUser }
    
    func updateUserProfile(userName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges { error in }
    }
    
    func forgetPwd(userMail: String, completion: @escaping (String?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: userMail) { error in
            guard error != nil else {
                completion(nil)
                return
            }
            guard let errorCode = AuthErrorCode.Code(rawValue: error?._code ?? 0) else { return }
            completion(errorCode.errorMessage)
        }
    }
}
