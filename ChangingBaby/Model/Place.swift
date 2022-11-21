//
//  Place.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 24/10/2022.


import Foundation
import CoreLocation
import MapKit

// Parsing and object Place is create
struct Place: Codable {
    // MARK: - Properties
    
    let name, streetNumber, streetName, city, category: String
    let zip: Int
    let lat, long: Double
}

// class Poi for add annotation
class Poi: NSObject, MKAnnotation {
    // MARK: - Properties
    
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    // initialize the properties
    init(name: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.coordinate = coordinate
    }
}
