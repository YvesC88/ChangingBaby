//
//  PlaceService.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 24/10/2022.
//

import Foundation
import FirebaseFirestore
import CoreLocation

class PlaceService {
    // MARK: - Properties
    
    // MARK: - Methods
    
    func build(from documents: [QueryDocumentSnapshot]) -> [Place] {
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
    // fetch places in FireStore
    func fetchPlaces(collectionID: String, completion: @escaping ([Place]) -> Void) {
        let db = Firestore.firestore()
        db.collection("places").addSnapshotListener { (querySnapshot, error) in
            guard let error = error else {
                completion(self.build(from: querySnapshot?.documents ?? []))
                return
            }
            print("Error getting documents: \(error)")
        }
    }
}
