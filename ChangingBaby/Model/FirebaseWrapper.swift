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
    func fetch(collectionID: String, completion: @escaping ([Place]?, String?) -> ())
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
        db.collection("users").document(userId).setData(["name": name, "uid": userId as Any]) { error in
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
    
    func fetch(collectionID: String, completion: @escaping ([Place]?, String?) -> ()) {
        let db = Firestore.firestore()
        db.collection("places").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                completion(self.build(from: querySnapshot.documents), nil)
            } else {
                completion(nil, error?.localizedDescription)
            }
        }
    }
    
    internal func build(from documents: [QueryDocumentSnapshot]) -> [Place] {
        var places = [Place]()
        for document in documents {
            places.append(Place(name: document["name"] as? String ?? "",
                                streetNumber: document["streetNumber"] as? String ?? "",
                                streetName: document["streetName"] as? String ?? "",
                                city: document["city"] as? String ?? "",
                                category: document["category"] as? String ?? "",
                                zip: document["zip"] as? Int ?? 00000,
                                lat: document["lat"] as? Double ?? 0.0,
                                long: document["long"] as? Double ?? 0.0,
                                hours: document["hours"] as? [String] ?? []))
        }
        return places
    }
}
