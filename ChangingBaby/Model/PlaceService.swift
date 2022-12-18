//
//  PlaceService.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 24/10/2022.
//

import Foundation
import CoreLocation
import Firebase

class PlaceService {
    // MARK: - Properties
    let firebaseWrapper: FirebaseProtocol
    
    init(wrapper: FirebaseProtocol) {
        self.firebaseWrapper = wrapper
    }
    // MARK: - Methods
    
//    func fetch(completion: @escaping (QuerySnapshot?, String?) -> ()) {
//        firebaseWrapper.fetch(collectionID: "places") { querySnapshot, error in
//            if let querySnapshot = querySnapshot {
//                completion(querySnapshot, nil)
//            } else {
//                completion(nil, error)
//            }
//        }
//    }
    
    // fetch places in FireStore
    func fetchPlaces(collectionID: String, completion: @escaping ([Place]) -> ()) {
        let db = Firestore.firestore()
        db.collection("places").addSnapshotListener { (querySnapshot, error) in
            guard error != nil else {
                completion(self.build(from: querySnapshot?.documents ?? []))
                return
            }
            completion([])
        }
    }
    
    private func build(from documents: [QueryDocumentSnapshot]) -> [Place] {
        var places = [Place]()
        for document in documents {
            places.append(Place(name: document["name"] as? String ?? "",
                                streetNumber: document["streetNumber"] as? String ?? "",
                                streetName: document["streetName"] as? String ?? "",
                                city: document["city"] as? String ?? "",
                                category: document["category"] as? String ?? "",
                                zip: document["zip"] as? Int ?? 00000,
                                lat: document["lat"] as? Double ?? 0.0,
                                long: document["long"] as? Double ?? 0.0))
        }
        return places
    }
}
