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
    
    // fetch places in FireStore
    func fetchPlaces(collectionID: String, completion: @escaping ([Place], String?) -> ()) {
        firebaseWrapper.fetch(collectionID: "Place") { place, error in
            if let place = place {
                completion(place, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    func addNewPlace(name: String, streetNumber: String?, streetName: String, city: String) {
        let newPlace: [String: Any] = ["name": name,
                                       "streetNumber": streetNumber ?? "",
                                       "streetName": streetName,
                                       "city": city]
        let db = Firestore.firestore()
        db.collection("inholdplace").document().setData(newPlace)
    }
}
