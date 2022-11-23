//
//  UserService.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 08/11/2022.
//

import Foundation
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
    
    func createUser(userName: String, mail: String, password: String, completion: @escaping (String) -> ()) {
        Auth.auth().createUser(withEmail: mail, password: password) { result, error in
            if let error = error {
                // une erreur s'est produite puis la stock dans completion
                completion(error.localizedDescription)
            } else {
                // création du compte réussie
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["userName": userName, "uid": result!.user.uid]) { (error) in
                    if error != nil {
                        // présenter un message d'erreur
                        print("La création de compte n'a pas aboutie")
                    } else {
                        // présenter un message confirmant la création du compte
                        print("Compte créé avec succès !")
                    }
                }
            }
        }
    }
    
    // sign in an user
    func signIn(mail: String, password: String, completion: @escaping (String) -> ()) {
        Auth.auth().signIn(withEmail: mail, password: password) { result, error in
            if let error = error {
                completion(error.localizedDescription)
            }
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
    
    func forgetPwd(userMail: String, completion: @escaping (Error) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: userMail) { error in
            if let error = error {
                completion(error)
            }
        }
    }
}
